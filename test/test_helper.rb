require "minitest/autorun"
require 'minitest-metadata'
require 'minitest/spec'
require 'minitest/reporters'
require "minitest/capybara"
require "minitest/features"

require 'capybara/poltergeist'
require 'pry'

# require 'capybara-screenshot/minitest'

Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new(:color => true),
  ENV,
  Minitest.backtrace_filter
)

# Capybara Configuration
Capybara.configure do |config|
  config.run_server = false
  config.app_host = 'http://localhost:3000'
  config.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :firefox)
  end

  # config.save_and_open_page_path = File.dirname(__FILE__) + '/../snapshots'
  config.default_driver = :selenium
end
Capybara.javascript_driver = :poltergeist

# Capybara::Screenshot.register_filename_prefix_formatter(:minitest) do |example|
#   "screenshot_#{example.description.gsub(' ', '-').gsub(/^.*\/spec\//,'')}"
# end
# Capybara.save_and_open_page_path = "/test/failures"

# Uncomment for awesome colorful output
require "minitest/pride"

# for minitest/spec
class AcceptanceSpec < Minitest::Spec
  include Capybara::DSL

  before do
    if metadata[:js]
      Capybara.current_driver = Capybara.javascript_driver # Used for Ajax Request
    else
      Capybara.current_driver = Capybara.default_driver
    end
  end

  def teardown
    Capybara.reset_session!
    Capybara.use_default_driver
  end
end
