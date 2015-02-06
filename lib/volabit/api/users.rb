
# API endpoints for user account management.
module Users
  # Creates a new user.
  # @note Special permissions are required to perform this action.
  def create_user(acceptance:, email:, pass: '')
    post_to_resource 'api/v1/users', {
      accepts_terms_of_service: acceptance,
      user: {
        email: email, password: pass
      }
    }
  end

  alias_method :new_user, :create_user

  # Get the account information from the user that authorized the app.
  def me
    get_resource 'api/v1/users/me'
  end

  alias_method :user_data, :me
end

module Volabit
  module API
    include Users
  end
end
