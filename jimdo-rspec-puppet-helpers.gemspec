# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{jimdo-rspec-puppet-helpers}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Bonkowski", "Ingo Oeser", "Soenke Ruempler", "Ilya Margolin"]
  s.date = %q{2014-04-03}
  s.description = %q{rspec-puppet helpers}
  s.email = ["infrateam@jimdo.com"]
  s.files = [".gitignore", ".rspec", "Gemfile", "Gemfile.lock", "LICENSE", "README.md", "Rakefile", "jimdo-rspec-puppet-helpers.gemspec", "lib/jimdo-rspec-puppet-helpers.rb", "spec/puppet_file_contains_spec.rb", "spec/spec_helper.rb"]
  s.homepage = %q{}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{rspec-puppet helpers}
  s.test_files = ["spec/puppet_file_contains_spec.rb", "spec/spec_helper.rb"]

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
