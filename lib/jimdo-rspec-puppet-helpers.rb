require "jimdo-rspec-puppet-helpers/version"
require 'rspec'

RSpec::Matchers.define :puppet_file_contains do |file, expected|
  match do |actual|
    files = actual.resource('file', file).to_hash[:source].map do |catalog_file|
      catalog_file.gsub(/^puppet:\/\//, '')
    end
    found_file = nil
    files.each do |catalog_file|
      sliced_path = catalog_file.split('/')
      path = File.expand_path(
        File.join(
          sliced_path[1..2],
          'files',
          sliced_path.slice(3..sliced_path.length)
         )
      );
      if File.file?(path) then
        found_file = path
        break
      end
    end

    if !found_file then
      false
    else
      expected.match(IO.read(found_file)) != nil
    end
  end

  failure_message_for_should do |actual|
    "expected that it matches #{expected}"
  end
end
