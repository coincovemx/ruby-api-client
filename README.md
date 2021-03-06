
[![Gem Version](https://badge.fury.io/rb/volabit.svg)](http://badge.fury.io/rb/volabit)
[![Build Status](https://travis-ci.org/coincovemx/ruby-api-client.svg?branch=master)](https://travis-ci.org/coincovemx/ruby-api-client)

# Volabit

Volabit's API library for Ruby. Integrate the Volabit services in your apps with ease.

You can see the available methods on the [project wiki][wiki]. Details of the API use can be found on the [official page][api-docs].

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'volabit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ git clone https://github.com/coincovemx/ruby-api-client.git
    $ cd ruby-api-client
    $ bundle
    $ gem build volabit.gemspec
    $ gem install volabit-[version].gem

## Usage

1) Instance a new Volabit client object.

```ruby
app_id   = 'The registered API for your APP.'
secret   = 'The registered secret for your APP.'
callback = 'The registered callback URL for your APP'

volabit_client = Volabit::Client.new(app_id, secret, callback)
```

Note that by default the Volabit client uses the **production** environment. If you want to use the **test** environment, set the sandbox flag to `true` before requesting the authorization code.

```ruby
volabit_client.sandbox true
```

You can also provide this parameter upon client instantiation.

```ruby
environment    = 'sandbox'
volabit_client = Volabit::Client.new(app_id, secret, callback, environment)
```

2) Get the URL that will allow the user to authorize your app to use his/her account. (It should be opened in a browser.)

```ruby
auth_url = volabit_client.authorize
```

3) After you get the authorization code (sent at the callback URL that you provided), you'll use it to get the refresh and access tokens. This code can be used only once, so be sure to store the token object for later use or your app will have to be reauthorized.

```ruby
volabit_client.request_tokens 'The given authorization code.'
```

Or, if you already have an `access_token` and a `refresh_token` from the last call, you can use:

```ruby
tokens = {
  access_token: 'access_token',
  refresh_token: 'refresh_token'
}
volabit_client.use_tokens(tokens)
```

4) You're ready to use our API. Just call any method listed [here][wiki].

```ruby
tickers = volabit_client.tickers
# => {
#       "btc_usd_buy":"226.06",
#       "btc_usd_sell":"226.56",
#       "usd_mxn_buy":"14.53",
#       "usd_mxn_sell":"15.13",
#       "btc_mxn_buy":"3285.63",
#       "btc_mxn_sell":"3427.3"
#    }
```

**Note**: You can obtain the current tokens used by the client with the method `Client#tokens`. Be sure to keep them **safe** withing your application for later use.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ruby-api-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


[wiki]: https://github.com/coincovemx/ruby-api-client/wiki
[api-docs]: https://coincovemx.github.io/


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/coincovemx/ruby-api-client/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

