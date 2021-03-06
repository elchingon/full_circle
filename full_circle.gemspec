# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'full_circle/version'

Gem::Specification.new do |gem|
  gem.name          = "full_circle"
  gem.version       = FullCircle::VERSION
  gem.authors       = ["Aaron Renner", "Alexii Carey"]
  gem.email         = ["alexii@e7systems.com"]
  gem.description   = %q{Library for interfacing with the 360Directories API}
  gem.summary       = %q{Library for interfacing with the 360Directories API}
  gem.homepage      = "https://github.com/elchingon/full_circle"
  gem.required_ruby_version = ">= 2.0.0"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "virtus", '~> 1.0'
  gem.add_dependency "multi_xml"
  gem.add_dependency "activesupport", ">= 3.2"
  gem.add_development_dependency "rspec", '~> 3.2'
  gem.add_development_dependency "shoulda-matchers", '~> 2.6'
  gem.add_development_dependency "vcr", '~> 2.9'
  gem.add_development_dependency "webmock"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "pry"
end
