require 'rspec'

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
      @message = "expected source attribute on #{resource}, found: #{resource.to_hash.keys.join(",")}"
      next
    end
    files = source_attr.map do |catalog_file|
      catalog_file.gsub(/^puppet:\/\//, '')
    end
    found_file = nil
    files.each do |catalog_file|
      sliced_path = catalog_file.split('/')
      module_path = sliced_path[1..2]
      relative_path_in_puppet_files = sliced_path.slice(3..sliced_path.length)

      # check whether we have rspec fixtures
      if File.directory?("./spec/fixtures") then
        path = File.expand_path(
          File.join(
            'spec/fixtures',
            module_path,
            'files',
            relative_path_in_puppet_files
           )
        );
      # else use files in puppet source tree
      else
        path = File.expand_path(
          File.join(
            module_path,
            'files',
            relative_path_in_puppet_files
           )
        );
      end
      if File.file?(path) then
        found_file = path
        break
      end
    end

    if !found_file then
      @message = "no files specified in 'source' exist"
      false
    else
      @message = "expected that #{file}(source=#{found_file}) matches #{expected}"
      expected.match(IO.read(found_file)) != nil
    end
  end

  failure_message_for_should do |actual|
    @message
  end
end
