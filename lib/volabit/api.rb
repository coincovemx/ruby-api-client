
require_relative 'api/rates'
require_relative 'api/users'
require_relative 'api/slips'
require_relative 'api/transactions'

module Volabit
  module API
    private

    # Request a resource using the GET method.
    def get_resource(resource, params = nil)
      raise no_token_error unless @token
      @token.refresh if @token.expired?
      response = @token.get(resource, params: params)
      JSON.parse response.body, :symbolize_names => true
    end

    def post_to_resource(resource, params)
      raise no_token_error unless @token
      @token.refresh if @token.expired?
      response = @token.post(resource, params: params)
      JSON.parse response.body, :symbolize_names => true
    end

    def delete_resource(resource)
      raise no_token_error unless @token
      @token.refresh if @token.expired?
      response = @token.delete(resource)
      JSON.parse response.body, :symbolize_names => true
    end

    def no_token_error
      'Error: you have to run get_token or set_token before use this method.'
    end
  end
end
