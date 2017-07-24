require "spec_helper"

RSpec.describe "emoji" do
  before { visit("rendering-examples/emoji") }

  it "outputs the expected page" do
    html = get_sample_page('rendering-examples/emoji.html')
    expect(page_as_html(page)).to include(html)
  end
end
