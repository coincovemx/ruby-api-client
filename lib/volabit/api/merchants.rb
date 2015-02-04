
# Methods to perform merchant related operations.
module Merchants
  # Generates a special address to receive a bitcoin payment that will be
  # instantly converted to the designated currency.
  # @note This action requires special permissions to be performed.
  def new_payment(currency:, amount:)
    post_to_resource 'api/v1/users/me/green-addresses', {
      currency: currency,
      amount: amount
    }
  end
end

module Volabit
  module API
    include Merchants
  end
end
