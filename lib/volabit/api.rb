
require_relative 'api/rates'
require_relative 'api/users'
require_relative 'api/slips'
require_relative 'api/transactions'

module Volabit
  module API
  private

    # Request given resource using the provided method and params.
    def resource(verb, resource, params = nil)
      no_token_error unless @token
      refresh_tokens if @token.expired?

      response = @token.send(verb, resource, params: params)
      JSON.parse response.body, symbolize_names: true
    end

    # Raises an exception intended when there is no OAuth2::AccessToken
    # available.
    def no_token_error
      raise StandardError, 'Call get_tokens or use_tokens before this method.'
    end
  end
end
