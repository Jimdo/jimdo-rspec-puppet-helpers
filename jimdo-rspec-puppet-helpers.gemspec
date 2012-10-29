# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jimdo-rspec-puppet-helpers/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Daniel Bonkowski"]
  gem.email         = ["bonko@jimdo.com"]
  gem.description   = %q{rspec-puppet helpers}
  gem.summary       = %q{rspec-puppet helpers}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "jimdo-rspec-puppet-helpers"
  gem.require_paths = ["lib"]
  gem.version       = '0.0.2'
end
