
# Methods to perform transactions with bitcoins and fiat currencies.
module Transactions
  # Instantly buy bitcoins using fiat balance.
  # @note The amount is expected in satoshis.
  def buy_bitcoins(amount:)
    resource :post, 'api/v1/users/me/buys', amount: amount
  end

  # Instantly sell bitcoins to get fiat balance.
  # @note The amount is expected in satoshis.
  def sell_bitcoins(amount:)
    resource :post, 'api/v1/users/me/sells', amount: amount
  end

  # Instantly send fiat or bitcoins to an address.
  # @note The amount is expected in satoshis for bitcoins and cents for
  #       fiat currencies.
  def send_money(currency:, amount:, address:)
    resource :post, 'api/v1/users/me/send', {
      amount: amount,
      address: address,
      currency: currency
    }
  end

  alias send_funds send_money

  # Requests a special address to receive a bitcoin payment that will be
  # converted to the designated currency.
  def new_payment(currency:, amount:)
    resource :post, 'api/v1/users/me/green-addresses', {
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
