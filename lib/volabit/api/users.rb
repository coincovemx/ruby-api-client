
# API endpoints for user account management.
module Users
  # Request the creation of a new user with the given params.
  # @note This action requires partner privileges.
  def create_user(acceptance:, email:, pass: '')
    post_to_resource 'api/v1/users', {
      accepts_terms_of_service: acceptance,
      user: {
        email: email, password: pass
      }
    }
  end

  alias_method :new_user, :create_user

  # Gets the information details of the app user.
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
