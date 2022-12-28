# Csvbuilder::Exporter

[Csvbuilder::Exporter](https://github.com/joel/csvbuilder-exporter) is part of the [csvbuilder-collection](https://github.com/joel/csvbuilder)

The exporter contains the implementation for exporting a collection of objects as a CSV file.

## Installation

The gem doesn't need [csvbuilder-collection](https://github.com/joel/csvbuilder) and can be installed alone.

Install the gem and add to the application's Gemfile by executing:

    $ bundle add csvbuilder-exporter

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install csvbuilder-exporter

## Usage

Exporting is straightforward; a `CsvRowModel` is needed to map the Ruby Object. Often an `ActiveRecord` Object. A `CsvExportModel` is required to carry the specifics of exporting.

```ruby
class UserCsvRowModel
  include Csvbuilder::Model

  column :first_name
  column :last_name
end
```

NOTE: If shipping is the only need, both classes can be merged.

```ruby
class UserCsvExportModel
  include Csvbuilder::Model
  include Csvbuilder::Export

  column :first_name
  column :last_name
end
```

You need to provide both object collection and exporter class as follow:

```ruby
collection = User.all

exporter = Csvbuilder::Export::File.new(UserCsvExportModel, context = {})

exporter.headers
# => "First Name", "Last Name"

exporter.generate do |csv|
  collection.each do |user|
    csv.append_model(user, another_context: true)
  end
end
# => "First Name,Last Name\nJohn,Doe\n"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joel/csvbuilder-exporter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/csvbuilder-exporter/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Csvbuilder::Exporter project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/csvbuilder-exporter/blob/main/CODE_OF_CONDUCT.md).
