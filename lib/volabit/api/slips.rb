
# Methods to manage slips in the user wallet.
module Slips
  # Creates a slip that can be used to load the user wallet.
  def new_slip(currency:, amount:, type:)
    resource :post, 'api/v1/users/me/slips', {
      currency: currency,
      amount: amount,
      type: type
    }
  end

  alias create_slip new_slip

  # Gets the information of a specific slip.
  def get_slip_data(id:)
    empty_param_error('id') if id.to_s.eql? ''
    resource :get, "api/v1/users/me/slips/#{id}"
  end

  alias slip_data get_slip_data

  # Deletes a specific slip.
  def delete_slip(id:)
    empty_param_error('id') if id.to_s.eql? ''
    resource :delete, "api/v1/users/me/slips/#{id}"
  end

  # Informs of a receipt used to load a wallet's slip.
  def report_receipt(id:, amount:, affiliation:, authorization:)
    empty_param_error('id') if id.to_s.eql? ''
    resource :post, "api/v1/users/me/slips/#{id}/report", {
      amount: amount,
      affiliation_number: affiliation,
      authorization_number: authorization
    }
  end

  # Lists the available options to load a slip.
  def get_load_methods
    resource :get, 'api/v1/users/me/slips/methods'
  end

  alias load_methods get_load_methods

private

  def empty_param_error(param)
    raise ArgumentError, ":#{param} must not be nil or empty."
  end
end

module Volabit
  module API
    include Slips
  end
end
