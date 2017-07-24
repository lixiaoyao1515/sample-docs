require "spec_helper"

RSpec.describe "rouge" do
  before { visit("rendering-examples/rouge") }

  it "outputs the expected page" do
    html = get_sample_page('rendering-examples/rouge.html')
    expect(page_as_html(page)).to include(html)
  end
end
