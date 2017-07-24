require "spec_helper"

RSpec.describe "Conref Data Associations" do
  it "outputs the expected page" do
    visit("conref/test-data")
    html = get_sample_page('conref/test-data.html')
    expect(page_as_html(page)).to include(html)
  end

  context 'altered by page version' do
    it 'uses a default page version when creating an association' do
      visit("conref/assoc-v1")
      html = get_sample_page('conref/assoc-v1.html')
      expect(page_as_html(page)).to include(html)
    end

    it 'can change association values based on the page var' do
      pending('Hubot currently build different versions and puts them into the proper directory structure. We need to recreate this somehow')
      visit("conref/assoc-v2")
      html = get_sample_page('conref/assoc-v2.html')
      expect(page_as_html(page)).to include(html)
    end

  end
end
