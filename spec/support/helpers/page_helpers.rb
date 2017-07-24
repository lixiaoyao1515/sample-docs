module PageHelpers
  def page_as_html(page)
    page.html.force_encoding('UTF-8')
  end

  def get_sample_page(path)
    File.open(File.join(File.dirname(__FILE__), "../../support/compiled_pages/#{path}")).read
  end
end
