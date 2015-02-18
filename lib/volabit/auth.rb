
require 'oauth2'

require_relative 'common'

module Volabit
  include Common::Constants
  extend  Common::Helpers

  # Methods to manage the OAuth2 authentication process.
  module Auth
    # Generates the URL to be opened in the browser so the user can authorize
    # the app to use his/her Volabit account.
    #
    # @param  url [String] callback URL to which the token will be sent on the
    #         redirection.
    # @return [String] URL to open in the resource owner browser.
    def authorize
      @oauth_client.auth_code.authorize_url redirect_uri: @url
    end

    # Gets the information of the tokens currently set on the client.
    #
    # @return [Hash] including the access and refresh tokens, the
    #         expiration POSIX time, and other configuration options.
    def tokens
      {
        access_token:  @token.token,
        refresh_token: @token.refresh_token,
        expires_in:    @token.expires_in,
        expires_at:    @token.expires_at,
        options:       @token.options
      }
    end

    # Requests and sets the access and refresh tokens to use the Volabit API
    # resources.
    #
    # @param  auth_token [String]
    # @return [Hash] with the tokens information. (See #tokens).
    def request_tokens(auth_code)
      @token = @oauth_client.auth_code.get_token(auth_code, redirect_uri: @url)
      (@token.params['error']) ? @token.params : tokens
    end

    # Loads the client with the provided token information.
    #
    # @param  tokens_hash [Hash] that must contain at least the access and
    #         refresh tokens.
    # @return [Hash] with the tokens information. (See #tokens).
    def use_tokens(tokens_info)
      @token = OAuth2::AccessToken.from_hash @oauth_client, tokens_info
      retrieve_missing_token_info if @token[:expires_at].nil?
      tokens
    end

    # Triggers a refresh of the current tokens.
    #
    # @return [Hash] with the tokens information. (See #tokens).
    # @note   This method is provided as convenience, as the client checks the
    #         expiration of the tokens before each call to the API.
    def refresh_tokens
      @token.refresh
      tokens
    end

    # Toggles the test environment with a boolean value.
    # @note Set it before requiring the user authorization or your app will need
    #       to be reauthorized.
    def sandbox(flag)
      case flag
      when true  then @oauth_client.site = Volabit.site_for 'sandbox'
      when false then @oauth_client.site = Volabit.site_for 'production'
      end
    end

    private

    # Gets and sets information about the expiration time for provided
    # tokens without it.
    def retrieve_missing_token_info
      info = JSON.parse @token.get('/oauth/token/info').body
      time_left = info['expires_in_seconds']

      @token.instance_variable_set '@expires_in', time_left
      @token.instance_variable_set '@expires_at', (Time.now.to_i + time_left)
    end

    # Instances a new OAuth client to manage authorizations.
    def set_oauth_client(id, secret, env)
      @oauth_client = OAuth2::Client.new(id, secret, {
        site: Volabit.site_for(env),
        raise_errors: false
      })
    end
  end
end
