require 'rspec'
require 'puppet'

def find_puppet_file(sources)
  Array(sources).each do |source|
    next unless source.start_with?("puppet:///modules")
    elems = source.split("/")
    Puppet[:modulepath].split(":").each do |modulepath|
      filepath = File.join(modulepath, elems[4], "files", *elems[5..-1])
      return filepath if File.exist?(filepath)
    end
  end
  nil
end

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

    found_file = find_puppet_file(source_attr)
    if found_file.nil? then
      @message = "no files specified in 'source' exist"
      next
    else
      @message = "expected that #{file} (source=#{found_file}) matches #{expected}"
      expected.match(IO.read(found_file)) != nil
    end
  end

  failure_message_for_should do |actual|
    @message
  end
end
