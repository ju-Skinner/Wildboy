# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wildboy/version'

Gem::Specification.new do |spec|
  spec.name          = "wildboy"
  spec.version       = Wildboy::VERSION
  spec.authors       = ["Julian Skinner"]
  spec.email         = ["ju.skinner@gmail.com"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency 'selenium-webdriver'
  spec.add_dependency "minitest-capybara"
  spec.add_dependency "minitest-reporters"
  spec.add_dependency "minitest-metadata"
  spec.add_dependency "poltergeist"
  # spec.add_dependency 'capybara-screenshot'

end