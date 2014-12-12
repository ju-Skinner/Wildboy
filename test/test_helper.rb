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
      timestamp = Time.new.strftime("%Y%m%d%H%M%S")
      filename = File.basename(method(name).source_location[0]).gsub(/.rb$/, '') # Gets the actual file_name for failure
      line_number = File.basename(failure.backtrace.grep(/#{filename}/)[0]).gsub(/(:in).*/,'').split(':')[1] # Locates the exception in stacktrace and gets the line number

      page_name = "#{filename}-#{line_number}-#{timestamp}#{rand(10**10)}.html"
      full_path = File.join('failures', page_name)

      result = page.save_page(full_path)

      #print(ANSI::Code.yellow {"\n  Screenshot: "}) # Will add color syntax later
      puts "\n  Screenshot: #{result}"
    end

    Capybara.reset_session!
    Capybara.use_default_driver
  end
  # def teardown
  #
  # end
end
