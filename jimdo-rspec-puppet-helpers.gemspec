# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.authors       = ["Daniel Bonkowski", "Ingo Oeser", "Soenke Ruempler", "Ilya Margolin"]
  gem.email         = ["infrateam@jimdo.com" ]
  gem.description   = %q{rspec-puppet helpers}
  gem.summary       = %q{rspec-puppet helpers}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "jimdo-rspec-puppet-helpers"
  gem.require_paths = ["lib"]
  gem.version       = '0.0.4'
end
