# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'full_circle/version'

Gem::Specification.new do |gem|
  gem.name          = "full_circle"
  gem.version       = FullCircle::VERSION
  gem.authors       = ["Aaron Renner"]
  gem.email         = ["aaron@animascodelabs.com"]
  gem.description   = %q{Library for interfacing with the 360Directories API}
  gem.summary       = %q{Library for interfacing with the 360Directories API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
