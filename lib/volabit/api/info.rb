
module Info
  def spot_prices(amount, from: 'BTC', to: 'MXN')
    raise ArgumentError, 'Currencies must be different.' if from.eql? to
    get_resource 'api/v1/spot-prices', {
      currency_from: from, currency_to: to, amount: amount
    }
  end

  def tickers
    get_resource 'api/v1/tickers'
  end
end
