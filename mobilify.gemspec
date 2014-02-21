# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mobilify/version'

Gem::Specification.new do |spec|
  spec.name          = "mobilify"
  spec.version       = Mobilify::VERSION
  spec.authors       = ["Johnson Denen"]
  spec.email         = ["jdenen@manta.com"]
  spec.description   = %q{page-object methods invoked with one call but defined contextually}
  spec.summary       = %q{page-object methods invoked with one call but defined contextually}
  spec.homepage      = "http://github.com/jdenen/mobilify"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "page-object"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "watir-webdriver"
  spec.add_development_dependency "webdriver-user-agent"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-given"
end
