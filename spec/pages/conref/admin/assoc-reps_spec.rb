require "spec_helper"

RSpec.describe "Conref Data Associations changed by rep" do
  it "outputs the expected toc and rep" do
    visit("conref/admin/assoc-rep1")
    html = get_sample_page('conref/admin/assoc-rep1.html')
    expect(page_as_html(page)).to include(html)
  end

  it 'can be altered by rep' do
    pending('I am unclear how this works. We need to recreate this somehow')
    visit("conref/admin/assoc-rep2")
    html = get_sample_page('conref/admin/assoc-rep2.html')
    expect(page_as_html(page)).to include(html)
  end
end
