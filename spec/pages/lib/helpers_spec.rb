require 'spec_helper'

RSpec.describe 'Content from helper file' do
  it 'Can use a helper file to generate content' do
    visit("lib/helper")
    expect(page).to have_content('Generated content from method')
  end
end
