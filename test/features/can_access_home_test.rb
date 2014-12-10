require "test_helper"


class MetaDataTest < AcceptanceSpec
  describe "Capybara" do

    it 'should use poltergeist with js metadata', :js do
      Capybara.current_driver.must_equal :poltergeist
    end

    it 'should use selenium without js metadata' do
      Capybara.current_driver.must_equal :selenium
    end
  end
end
