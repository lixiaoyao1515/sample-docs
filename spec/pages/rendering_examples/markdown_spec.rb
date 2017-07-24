require "spec_helper"

RSpec.describe "markdown" do
  before { visit("rendering-examples/markdown/") }

  it "outputs the expected page" do
    html = get_sample_page('rendering-examples/markdown.html')
    expect(page_as_html(page)).to include(html)
  end

  it "renders an ordered list" do
    expect(page).to have_content("1. Ordered sub-list And another item.")
  end
end
