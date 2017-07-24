require 'spec_helper'

RSpec.describe 'Layouts based on rules' do
  it 'uses the defined layout' do
    visit("rules/layout1")
    expect(page).to have_content('This is rendered in layout 1')

    visit('/')
    expect(page).to_not have_content('This is rendered in layout 1')
  end
end
