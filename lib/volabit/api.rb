
require_relative 'api/info'

module Volabit
  module API
    include Info

    private
    def get_resource(resource, params = nil)
      @token.refresh if @token.expired?
      @token.get(resource, params: params)
    end
  end
end
