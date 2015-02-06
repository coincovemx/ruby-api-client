
module Volabit
  module Common
    module Helpers
      # Gets the base URL for the API service that will be used.
      #
      # @param  env [String] The environment to be used.
      # @return [String] URL of the Volabit site if the environment is
      #         production, otherwise it will return the URL for the sanbox.
      def site_for(env)
        (env.eql? 'production') ? Volabit::PRODUCTION_SITE : Volabit::SANDBOX_SITE
      end
    end
  end
end
