require "spec_helper"

RSpec.describe "Conref Page Variables" do
  before { visit("conref/page-vars") }

  it "outputs the expected page" do
    html = get_sample_page('conref/page-vars.html')
    expect(page_as_html(page)).to include(html)
  end
end
