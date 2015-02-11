# Volabit

Volabit's API Ruby library. Integrate the Volabit services in your apps with ease.

You can see the available methods on the [project wiki][wiki]. Details of the API use can be found on the [official page][api-docs].

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'volabit'
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

1) Instance a new Volabit client object.

```ruby
app_id      = 'The registered API for your APP.'
secret      = 'The registered secret for your APP.'
callback    = 'The registered callback URL for your APP'

volabit_client = Volabit::Client.new(app_id, secret, callback)
```

Note that by default the Volabit client uses the **production** environment. If you want to use the **test** environment, set the sandbox flag to `true` before requesting the authorization code.

```ruby
volabit_client.sandbox true
```

2) Get the URL that will allow the user to authorize your app to use his/her account. (It should be opened in a browser.)

```ruby
auth_url = volabit_client.authorize
```

3) After you get the authorization code (sent at the callback URL that you provided), you'll use it to get the refresh and access tokens. This code can be used only once, so be sure to store the token object for later use or your app will have to be reauthorized.

```ruby
volabit_client.get_token 'The given authorization code.'
```

4) If you already have a `token` and a `refresh_token` you can use:

```ruby
volabit_client.use_token 'token', 'refresh_token'
```

5) You're ready to use our API. Just call any method listed [here][wiki].

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


## Contributing

1. Fork it ( https://github.com/[my-github-username]/volabit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


[wiki]: https://github.com/coincovemx/api-client/wiki
[api-docs]: https://coincovemx.github.io/
