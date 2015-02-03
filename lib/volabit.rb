
require 'volabit/auth'
require 'volabit/api'
require 'volabit/version'

module Volabit
  class Client
    include Auth
    include API

    def initialize(app_id:, app_secret:, app_url:, environment: 'production')
      @url = app_url
      set_oauth_client(app_id, app_secret, environment)
    end
  end
end
