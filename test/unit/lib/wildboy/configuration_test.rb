require 'test_helper'

describe Wildboy::Configuration do
  VALID_BASE_URL = 'http://www.google.com'

  it 'should initialize with some defaults' do
    config = Wildboy::Configuration.new({})
    config.base_url.must_eq VALID_BASE_URL
  end
end
