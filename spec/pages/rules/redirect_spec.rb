require 'spec_helper'

RSpec.describe 'Redirect' do
  it 'uses the defined layout' do
    visit("rules/redirect-from")
    expect(page).to have_content("Redirecting... Click here if you are not redirected.")
  end
end
