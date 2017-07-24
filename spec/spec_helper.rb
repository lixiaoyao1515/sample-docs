require "bundler/setup"
require "docs/builder"
require "capybara/rspec"
require "capybara/dsl"
require "support/helpers/page_helpers"

NANOC_SITE_ROOT =  File.join(File.dirname(__FILE__), "..")
NANOC_SITE_PATH =  File.join(NANOC_SITE_ROOT, "output")

# this does the file serving
class ImplictIndex
  def initialize(root)
    puts root
    @root = root
    @file_server = ::Rack::File.new(root)

    res_path = ::File.join(File.dirname(__FILE__), "..", "output")
    @res_server  = ::Rack::File.new(::File.expand_path(res_path))
  end
  attr_reader :root, :file_server, :res_server

  def call(env)
    path = env["PATH_INFO"]

    # if we are looking at / let's try index.html
    if path == "/" && exists?("index.html")
      env["PATH_INFO"] = "/index.html"
    elsif !exists?(path) && exists?(path + ".html")
      env["PATH_INFO"] += ".html"
    elsif exists?(path) && directory?(path) && exists?(File.join(path, "index.html"))
      env["PATH_INFO"] += "/index.html"
    end

    self.file_server.call(env)
  end

  def exists?(path)
    File.exist?(File.join(self.root, path))
  end

  def directory?(path)
    File.directory?(File.join(self.root, path))
  end
end


# Wire up Capybara to test again static files served by Rack
# Courtesy of http://opensoul.org/blog/archives/2010/05/11/capybaras-eating-cucumbers/

Capybara.app = Rack::Builder.new do
  map "/" do
    # use Rack::CommonLogger, $stderr
    use Rack::Lint
    run ImplictIndex.new(NANOC_SITE_PATH)
  end
end.to_app

Capybara.register_driver :phantomjs do |app|
  Capybara::Selenium::Driver.new(app, browser: :phantomjs)
end

Capybara.javascript_driver = :selenium

RSpec.configure do |config|
  config.include PageHelpers
  config.order = "random"
  config.color = true
  config.formatter = :progress
  config.filter_run_excluding skip: true

  config.add_setting :nanoc_site_path
  config.add_setting :nanoc_site_root
  config.nanoc_site_root = NANOC_SITE_ROOT
  config.nanoc_site_path = NANOC_SITE_PATH

  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers

  config.before do
    if self.class.include?(Capybara::DSL)
      example = RSpec.current_example
      Capybara.current_driver = Capybara.javascript_driver if example.metadata[:js]
      Capybara.current_driver = example.metadata[:driver] if example.metadata[:driver]
    end
  end
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.after do
    if self.class.include?(Capybara::DSL)
      Capybara.use_default_driver
    end
  end

  config.before(:suite) do
    path = RSpec.configuration.nanoc_site_root
    Dir.chdir(path) do
      system "bundle exec rake build"
    end
  end

  config.after(:suite) do
    require "fileutils"
    FileUtils.rm_rf(RSpec.configuration.nanoc_site_path)
    FileUtils.rm_rf(File.join(RSpec.configuration.nanoc_site_root, "tmp"))
  end

end
