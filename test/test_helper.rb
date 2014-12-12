require "minitest/autorun"
require 'minitest-metadata'
require 'minitest/spec'
require 'minitest/reporters'
require "minitest/capybara"
require "minitest/features"

require 'capybara/poltergeist'
require 'pry'

Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new(:color => true)
#   ,ENV
#   ,Minitest.backtrace_filter
)

# Capybara Configuration
Capybara.configure do |config|
  config.run_server = false
  config.app_host = 'http://localhost:3000' #'http://acceptance.iclaimsonline.com'
  config.asset_host = config.app_host
  config.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :firefox)
  end

  config.save_and_open_page_path = Pathname.new(File.expand_path "failures")
  config.default_driver = :selenium
  config.javascript_driver = :poltergeist
end

# Uncomment for awesome colorful output
require "minitest/pride"

# for minitest/spec
class Minitest::Spec
  include Capybara::DSL

  before do
    if metadata[:js]
      Capybara.current_driver = Capybara.javascript_driver # Used for Ajax Request
    else
      Capybara.current_driver = Capybara.default_driver
    end
  end

  after  do
    if ['F', 'E'].include?(result_code)
      puts "Passed: #{passed?}, Error: #{error?}, Failed: #{failures.size}"

      # filename = File.basename(meta[:file_path])
      # line_number = meta[:line_number]
      # screenshot_name = "screenshot-#{filename}-#{line_number}.png"
      # screenshot_name = "screenshot.png"
      # path = Pathname.new(File.expand_path "test/failures")
      # screenshot_path = "#{path}/#{screenshot_name}"
      puts metadata
      result = page.save_page

      puts "\n Screenshot: #{result}"
    end

    Capybara.reset_session!
    Capybara.use_default_driver
  end
  # def teardown
  #
  # end
end
