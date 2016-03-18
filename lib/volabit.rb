
require_relative 'volabit/auth'
require_relative 'volabit/api'
require_relative 'volabit/version'

module Volabit
  # Class that handles authorizations and API calls.
  class Client
    include Auth
    include API

    def initialize(app_id, app_secret, app_url, env = 'production')
      @url = app_url
      set_oauth_client(app_id, app_secret, env)
    end
  end
end
