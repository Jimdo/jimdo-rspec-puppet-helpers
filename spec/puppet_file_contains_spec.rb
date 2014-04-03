require 'spec_helper'

describe 'puppet_file_contains' do
  context "resource not found" do
    subject {
      catalog = double()
      resource = double()
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
      catalog = double()
      resource = double()
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

  context "resource is found, source is present" do
    subject {
      catalog = double()
      resource = double()
      catalog.stub(:resource) { resource }
      resource.stub(:to_hash) { { :source => ['puppet:///modules/modulex/path1', 'puppet:///modules/modulex/path2'] } }
      catalog
    }

    context "no files found" do
      it "will raise ExpectationNotMetError with 'expected source attribute'" do
        expect {
          should puppet_file_contains('/path/file', %r'regex')
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError, /no files specified in 'source' exist/)
      end
    end

    context "some file is found, but does not match regex" do
      it "will raise ExpectationNotMetError with 'expected source attribute'" do
        File.stub(:file?) { true }
        IO.stub(:read) { 'something else' }
        expect {
          should puppet_file_contains('/path/file', %r'regex')
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError, %r(expected that /path/file\(source=.*modules/modulex/files/path1\) matches))
      end
    end

    context "some file is found and matches regex" do
      it "will raise ExpectationNotMetError with 'expected source attribute'" do
        File.stub(:file?) { true }
        IO.stub(:read) { 'I do match a regex' }
        should puppet_file_contains('/path/file', %r'regex')
      end
    end
  end

end
