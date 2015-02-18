
require_relative 'api/rates'
require_relative 'api/users'
require_relative 'api/slips'
require_relative 'api/transactions'

module Volabit
  module API
    private

    # Request given resource using the provided method and params.
    def resource(verb, resource, params = nil)
      raise no_token_error unless @token
      @token.refresh! if @token.expired?

      response = @token.send(verb, resource, params: params)
      JSON.parse response.body, :symbolize_names => true
    end

    def no_token_error
      'Error: you have to run get_token or set_token before use this method.'
    end
  end
end
