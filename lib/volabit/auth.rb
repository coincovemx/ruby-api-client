
require 'oauth2'

require 'volabit/auth/version'
require 'volabit/common'

module Volabit
  include Common::Constants

  module Auth
    class Manager
      include Common::Helpers

      def initialize(id, secret, app_url, env = 'production')
        @app_url = app_url
        @client  = OAuth2::Client.new(id, secret, site: site_for(env))
      end

      # Generates the URL to be opened in the browser so the user can authorize
      # the app to use his/her Volabit account.
      #
      # @param  url [String] callback URL to which the token will be sent on the
      #         redirection.
      # @return [String] URL to open in the resource owner browser.
      def authorize
        @client.auth_code.authorize_url redirect_uri: @app_url
      end

      # Requests the access and refresh tokens to use the Volabit API resources.
      #
      # @param  auth_token [String]
      # @return [OAuth2::AccessToken] object that includes the credentials to
      #         access the API and the methods to renew itself.
      def get_token(auth_code)
        @client.auth_code.get_token auth_code, redirect_uri: @app_url
      end
    end
  end
end
