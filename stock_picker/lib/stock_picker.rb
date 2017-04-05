def stock_picker(stock_prices)

  # Possible errors that can be raised
  raise ArgumentError unless stock_prices.is_a?(Array)
  if stock_prices.empty?
    raise "No stock prices given"
  end
  if stock_prices.length == 1
    raise "Cannot determine days to buy/sell (only one stock price was given)"
  end


  most_profitable = [0, 1]
  biggest_profit = stock_prices[0] - stock_prices[1]

  (0...stock_prices.length).each do |buy_day|
    (buy_day + 2...stock_prices.length).each do |sell_day|
      buy_stock = stock_prices[buy_day]
      sell_stock = stock_prices[sell_day]
      current_profit = buy_stock - sell_stock

      if current_profit > biggest_profit
        most_profitable = [buy_day, sell_day]
        biggest_profit = buy_stock - sell_stock
      end
    end
  end

  # return nil if no profit found (biggest_profit is 0 or less)
  biggest_profit <= 0 ? nil : most_profitable
end
