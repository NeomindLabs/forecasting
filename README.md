# Forecasting

[![Gem Version](https://badge.fury.io/rb/forecasting.svg)](https://badge.fury.io/rb/forecasting)
[![Tests](https://github.com/NeomindLabs/forecasting/actions/workflows/ruby.yml/badge.svg)](https://github.com/NeomindLabs/forecasting/actions/workflows/ruby.yml)

A Ruby gem to interact with the Harvest Forecast API. Please note that there is currently [no official public API](https://help.getharvest.com/forecast/faqs/faq-list/api). This API client has been made by inspecting network requests using the Forecast website. This library is based on the excellent [Harvesting](https://github.com/fastruby/harvesting) gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'forecasting'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install forecasting

## Usage

In order to start using this gem you will need your personal token and an account id:

You can find these details over here: https://id.getharvest.com/developers

If you don't specify values for `access_token` or `account_id`, it will default to these environment variables:

* `ENV['FORECAST_ACCESS_TOKEN']`
* `ENV['FORECAST_ACCOUNT_ID']`

```ruby
# $ export FORECST_ACCESS_TOKEN=xxx
# $ export FORECAST_ACCOUNT_ID=12345678
client = Forecasting::Client.new
client.whoami
=> #<Forecasting::Models::User:0x000000010488e370 @attributes={"id"=>212737, ... }>
```

If the access token or account id is invalid a `Forecasting::AuthenticationError` will be raised:

```ruby
client = Forcasting::Client.new(access_token: "foo", account_id: "bar")
client.whoami
=> #<Forecasting::AuthenticationError: {"reason":"non-existent-token","account_id":"bar"}>
```

With a valid access token and account id:

```ruby
client = Forecasting::Client.new(access_token: "<your token here>", account_id: "<your account id here>")
user = client.whoami
#<Forecasting::Models::User:0x000000010e238ac0 @attributes={"id"=>212737, ... }>

user.id
# => 212737
```

## Releases

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).