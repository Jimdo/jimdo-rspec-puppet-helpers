require 'spec_helper'

describe 'puppet_file_contains' do
  before do
    Puppet[:modulepath] = "spec/fixtures"
  end

  context "resource not found" do
    subject {
      catalog = double
      resource = double
      catalog.stub(:resource) { nil }
      catalog
    }
    it "will raise ExpectationNotMetError with 'expected File[/path/file] in catalog, not found!'" do
      expect {
        should puppet_file_contains('/path/file', %r'regex')
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError, %r(expected 'File\[/path/file\]' in catalog, not found!))
    end
  end

  context "resource does not contain 'source' key" do
    subject {
      catalog = double
      resource = double
      catalog.stub(:resource) { resource }
      resource.stub(:to_hash) { { :some_attribute => 1, :some_other_attribute => 2} }
      catalog
    }
    it "will raise ExpectationNotMetError with 'expected source attribute'" do
      expect {
        should puppet_file_contains('/path/file', %r'regex')
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError, /expected source attribute on .*, found: some_attribute,some_other_attribute/)
    end
  end

  context "resource is found, file does not exist" do
    subject {
      catalog = double
      resource = double
      catalog.stub(:resource) { resource }
      resource.stub(:to_hash) { { :source => ['puppet:///modules/modulex/path1', 'puppet:///modules/modulex/path2'] } }
      catalog
    }

    it "will raise ExpectationNotMetError with 'no files exist'" do
      expect {
        should puppet_file_contains('/path/file', %r'regex')
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError, /no files specified in 'source' exist/)
    end
  end

  context "some file is found, but does not match regex" do
    subject {
      catalog = double
      resource = double
      catalog.stub(:resource) { resource }
      resource.stub(:to_hash) { { :source => ['puppet:///modules/modulex/path1', 'puppet:///modules/modulex/somefile.txt'] } }
      catalog
    }

    it "will raise ExpectationNotMetError with 'expected source attribute'" do
      expect {
        should puppet_file_contains('/path/file', %r'regex')
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError, /^#{Regexp.quote("expected that /path/file (source=#{Puppet[:modulepath]}/modulex/files/somefile.txt) matches")}/)
    end
  end

  context "some file is found and matches regex" do
    subject {
      catalog = double
      resource = double
      catalog.stub(:resource) { resource }
      resource.stub(:to_hash) { { :source => ['puppet:///modules/modulex/path1', 'puppet:///modules/modulex/anotherfile.txt'] } }
      catalog
    }

    it "will raise no exception" do
      should puppet_file_contains('/path/file', %r'some content')
    end
  end
end
