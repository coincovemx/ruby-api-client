
# Methods to perform transactions with bitcoins and fiat currencies.
module Transactions
  # Instantly buy bitcoins using fiat balance.
  # @note The amount is expected in satoshis.
  def buy_bitcoins(amount:)
    post_to_resource 'api/v1/users/me/buys', {
      amount: amount
    }
  end

  # Instantly sell bitcoins to fiat balance.
  # @note The amount is expected in satoshis.
  def sell_bitcoins(amount:)
    post_to_resource 'api/v1/users/me/sells', {
      amount: amount
    }
  end

  # Instantly send fiat or bitcoins to an address.
  # @note The amount is expected in satoshis for bitcoins and cents for fiat
  #       fiat currencies.
  def send(currency:, amount:, address:)
    post_to_resource 'api/v1/users/me/send', {
      amount: amount,
      address: address,
      currency: currency
    }
  end
end

module Volabit
  module API
    include Transactions
  end
end
