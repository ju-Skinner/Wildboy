require "test_helper"

describe "Capybara" do

  it 'should use poltergeist with js metadata', :js => true do
    Capybara.current_driver.must_equal :poltergeist
  end

  it 'should use selenium without js metadata' do
    Capybara.current_driver.must_equal :selenium
  end

  describe 'HTML' do
    it 'should save and open page on failure' do
      visit '/'
      page.must_have_content 'Welcome Julian Skinner'      
    end
  end
end
