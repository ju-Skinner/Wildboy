require "test_helper"

describe "CanAccessHome" do
  it 'should login with user' do
    visit '/'
    login!
    page.must_have_content "Welcome Julian Skinner"
  end
end


def login!
  within 'form#new_user' do
    fill_in 'Email', :with => 'j.skinner@arpc.com'
    fill_in 'Password', :with => 'yagni123'
  end

  click_link_or_button 'Sign in'
end
