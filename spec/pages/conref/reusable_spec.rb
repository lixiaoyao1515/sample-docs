require "spec_helper"

RSpec.describe "Conref Reusables" do
  context 'standard' do
    before { visit("conref/reusable") }

    it "outputs the expected page" do
      html = get_sample_page('conref/reusable.html')
      expect(page_as_html(page)).to include(html)
    end
  end

  context 'altered by page var' do
    it "outputs the expected page uses the correct variable v 2.10" do
      visit("conref/reusable-v1")

      html = get_sample_page('conref/reusable-v1.html')
      expect(page_as_html(page)).to include(html)
    end

    it "outputs the expected page uses the correct variable v 2.9" do
      pending('This will not work outside of hubot context')
      visit("conref/reusable-v2")

      html = get_sample_page('conref/reusable-v2.html')
      expect(page_as_html(page)).to include(html)
    end

  end
end
