
# Methods to perform transactions with bitcoins and fiat currencies.
module Transactions
  # Instantly buy bitcoins using fiat balance.
  # @note The amount is expected in satoshis.
  def buy_bitcoins(amount:)
    post_to_resource 'api/v1/users/me/buys', {
      amount: amount
    }
  end

  # Instantly sell bitcoins to get fiat balance.
  # @note The amount is expected in satoshis.
  def sell_bitcoins(amount:)
    post_to_resource 'api/v1/users/me/sells', {
      amount: amount
    }
  end

  # Instantly send fiat or bitcoins to an address.
  # @note The amount is expected in satoshis for bitcoins and cents for
  #       fiat currencies.
  def send(currency:, amount:, address:)
    post_to_resource 'api/v1/users/me/send', {
      amount: amount,
      address: address,
      currency: currency
    }
  end

  # Requests a special address to receive a bitcoin payment that will be
  # instantly converted to the designated currency.
  # @note This action requires merchant privileges.
  def new_payment(currency:, amount:)
    post_to_resource 'api/v1/users/me/green-addresses', {
      currency: currency,
      amount: amount
    }
  end
end

module Volabit
  module API
    include Transactions
  end
end
