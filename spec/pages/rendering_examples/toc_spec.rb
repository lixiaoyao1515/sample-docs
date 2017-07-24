require "spec_helper"

RSpec.describe "toc" do
  before { visit("rendering-examples/toc") }

  it "outputs the expected page" do
    html = get_sample_page('rendering-examples/toc.html')
    expect(page_as_html(page)).to include(html)
  end
end
