# jimdo-rspec-puppet-helpers

This gem adds a single rspec helper method to puppet-rspec in order to test the contents of a `file`
which has no `content` param, but a `source` param.

It looks up the path (e. g. `puppet:///modules/sample/test.ini`) like puppet would do and compares its content to
a given regular expression.

This is especially useful if you have a legacy codebase which excessively abuses `File->src`: E. g. you can do safe refactorings like this:

 1. Write tests for existing files with this helper
 
        it 'should be able to upload 100 files in one HTTP POST' do
          should puppet_file_contains('/etc/php5/php.ini', /^max_uploads = 100\n$/m)
        end

 2. Refactor: Make thie `File` a template and replace `source` with `content`
 3. Adjust test:

        should contain_file('/etc/php5/php.ini').with({
          :content => /^max_uploads = 100\n$/m
        })

 4. Use a module like inifile in order to get rid of the regular expression hell and in order to have real DESCRIPTIVE cfg mgmt.

## Installation

Add this line to your application's Gemfile:

    gem 'jimdo-rspec-puppet-helpers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jimdo-rspec-puppet-helpers

## Testing

    $ bundle install
    $ bundle exec rake spec

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
