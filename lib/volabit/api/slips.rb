
# Methods to manage slips in the user wallet.
module Slips
  # Creates a slip you can use to load your wallet.
  def new_slip(currency:, amount:, type:)
    post_to_resource 'api/v1/users/me/slips', {
      currency: currency,
      amount: amount,
      type: type
    }
  end

  # Gets the information of a specific slip.
  def get_slip_data(id:)
    get_resource "api/v1/users/me/slips/#{id}"
  end

  # Deletes a specific slip.
  def delete_slip(id:)
    delete_resource "api/v1/users/me/slips/#{id}"
  end

  # Informs of a receipt used to load a wallet's slip.
  def report_receipt(id:, amount:, affiliation:, authorization:)
    post_to_resource "api/v1/users/me/slips/#{id}/report", {
      amount: amount,
      affiliation_number: affiliation,
      authorization_number: authorization
    }
  end

  # Lists the available methods to load a slip.
  def get_load_methods
    get_resource 'api/v1/users/me/slips/methods'
  end
end

module Volabit
  module API
    include Slips
  end
end
