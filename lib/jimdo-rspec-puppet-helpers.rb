require 'rspec'
require 'puppet'
require 'puppet/file_serving'
require 'puppet/file_serving/metadata'

RSpec::Matchers.define :puppet_file_contains do |file, expected|
  match do |actual|
    @message = nil
    resource = actual.resource('file', file)
    if not resource then
      @message = "expected 'File[#{file}]' in catalog, not found!"
      next
    end
    source_attr = resource.to_hash[:source]
    if not source_attr then
      @message = "expected source attribute on #{resource}, found: #{resource.to_hash.keys.sort.join(",")}"
      next
    end

    file_data = nil
    source_attr.each do |source|
      file_data = Puppet::FileServing::Metadata.indirection.find(source)
      break if file_data
    end

    if !file_data then
      @message = "no files specified in 'source' exist"
      next
    else
      found_file = file_data.path

      @message = "expected that #{file}(source=#{found_file}) matches #{expected}"
      expected.match(IO.read(found_file)) != nil
    end
  end

  failure_message_for_should do |actual|
    @message
  end
end
