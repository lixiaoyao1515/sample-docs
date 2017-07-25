require 'spec_helper'

RSpec.describe 'Redirect' do
  it 'uses the defined layout' do
    pending('I am not sure why the redirect yml front matter is not working')
    visit("rules/redirect_from")
    expect(page).to have_content('On redirect to page.')
  end
end
