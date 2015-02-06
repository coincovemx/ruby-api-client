
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

    # Requests and sets the access and refresh tokens to use the Volabit API
    # resources.
    #
    # @param  auth_token [String]
    # @return [OAuth2::AccessToken] object that includes the credentials to
    #         access the API and the methods to renew itself.
    def get_token(auth_code)
      @token = @oauth_client.auth_code.get_token auth_code, redirect_uri: @url
    end

    # Toggles the test environment with a boolean value.
    # @note Set it before requiring the user authorization or your app will need
    # to be reauthorized.)
    def sandbox(flag)
      @oauth_client.site = case flag
      when true  then Volabit.site_for 'sandbox'
      when false then Volabit.site_for 'production'
      else
        @oauth_client.site
      end
    end

    private

    # Instances a new OAuth client to manage authorizations.
    def set_oauth_client(id, secret, env)
      @oauth_client = OAuth2::Client.new(id, secret, site: Volabit.site_for(env))
    end
  end
end
