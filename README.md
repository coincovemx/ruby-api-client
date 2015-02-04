# Volabit

Volabit's API library. Integrate the Volabit services in your apps with ease.

## Note

This library is in a early development stage so, at the moment, it is recommended to be used with caution as thing may change and broke from one day to another.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'volabit', :git => 'https://github.com/coincovemx/api-client.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ git clone https://github.com/coincovemx/api-client.git
    $ cd api-client
    $ bundle
    $ gem build volabit.gemspec
    $ gem install volabit-[version].gem

## Usage

Instance a new Volabit client object.

```ruby
app_id      = 'The registered API for your APP.'
secret      = 'The registered secret for your APP.'
callback    = 'The registered callback URL for your APP'
environment = 'The environment to work on (production or test)'

client = Volabit::Client.new(app_id: app_id, app_secret: secret, app_url: callback, environment: environment)
```

Get the URL that will allow the user to authorize your app to use his/her account. (It should be opened in a browser.)

```ruby
auth_url = client.authorize
```

After you get the authorization code (sent at the callback URL that you provided), you'll use it to get the refresh and access tokens.

```ruby
client.get_token 'The given authorization code.'
```

With these tokens, you'll be ready to call the services. The methods will return a response object. The contend can be retrieved with the `body` property and will be in the JSON format.

```ruby
response = client.tickers
response.body
# => {
#       "btc_usd_buy":"226.06",
#       "btc_usd_sell":"226.56",
#       "usd_mxn_buy":"14.53",
#       "usd_mxn_sell":"15.13",
#       "btc_mxn_buy":"3285.63",
#       "btc_mxn_sell":"3427.3"
#    }
```

You can see the available methods on the [corresponding modules][modules]. Details of the API use can be found on the [official page][api-docs].

## Contributing

1. Fork it ( https://github.com/[my-github-username]/volabit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


[modules]: https://github.com/coincovemx/api-client/tree/development/lib/volabit/api
[api-docs]: https://coincovemx.github.io/
