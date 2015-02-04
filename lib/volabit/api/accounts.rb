
# API endpoints for user account management.
module Accounts
  # Creates a new user.
  # @note Special permissions are required to perform this action.
  def create_account(acceptance:, email:, pass: '')
    post_to_resource 'api/v1/users', {
      accepts_terms_of_service: acceptance,
      user: {
        email: email, password: pass
      }
    }
  end

  # Get the account information from the user that authorized the app.
  def account_details
    get_resource 'api/v1/users/me'
  end
end

module Volabit
  module API
    include Accounts
  end
end
