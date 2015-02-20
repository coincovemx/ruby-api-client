
require 'oauth2'

require_relative 'common'

module Volabit
  include Common::Constants
  extend Common::Helpers

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
    # @return [Hash] including the access and refresh tokens and the
    #         expiration POSIX time, or an error message it one occurs
    #         while requesting the tokens.
    def tokens
      (@token.kind_of? OAuth2::AccessToken) ? @token.to_hash : @token
    end

    # Requests and sets the access and refresh tokens to use the Volabit API
    # resources.
    #
    # @param  auth_token [String]
    # @return [Hash] with the tokens information. (See #tokens).
    def request_tokens(auth_code)
      @token = @oauth_client.auth_code.get_token auth_code, redirect_uri: @url
      tokens
    end

    alias_method :get_token, :request_tokens

    # Loads the client with the provided token information.
    #
    # @param  tokens_hash [Hash] that must contain at least the access and
    #         refresh tokens.
    # @return [Hash] with the tokens information. (See #tokens).
    def use_tokens(tokens_hash)
      @token = OAuth2::AccessToken.from_hash @oauth_client, tokens_hash
      retrieve_missing_token_info if @token.expires_at.nil?
      tokens
    end

    alias_method :use_token, :use_tokens

    # Triggers a refresh of the current tokens.
    #
    # @return [Hash] with the tokens information. (See #tokens).
    # @note   This method is provided as convenience, as the client checks the
    #         expiration of the tokens before each call to the API.
    def refresh_tokens
      @token = @token.refresh!
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
      response = JSON.parse @token.get('/oauth/token/info').body

      if response['error']
        response['hint'] = 'Reauthorization may be required.'
        @token = response
      else
        time_left = response['expires_in_seconds']
        @token.instance_variable_set '@expires_at', (Time.now.to_i + time_left)
      end
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
