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

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
