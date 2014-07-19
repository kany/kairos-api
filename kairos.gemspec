# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kairos/version'

Gem::Specification.new do |spec|
  spec.name          = "kairos"
  spec.version       = Kairos::VERSION
  spec.authors       = ["Frank Kany"]
  spec.email         = ["frankkany@gmail.com"]
  spec.description   = %q{Ruby gem for the Kairos facial recognition API}
  spec.summary       = %q{Ruby gem for the Kairos facial recognition API}
  spec.homepage      = "https://github.com/kany/kairos-api"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.6"
  spec.add_development_dependency "webmock", '~> 1.6'
  spec.add_development_dependency "pry"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "typhoeus"

  spec.add_runtime_dependency "faraday", "~> 0.8.0"
  spec.add_runtime_dependency "faraday_middleware", "~> 0.8.7"
  spec.add_runtime_dependency "hashie", "~> 1.2.0"
  spec.add_runtime_dependency "multi_json", "~> 1.3"
end
