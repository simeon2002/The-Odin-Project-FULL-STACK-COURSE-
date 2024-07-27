def stock_picker(prices)
  prices.each_with_index.reduce(Array.new(2, 0)) do |buy_and_sell_price_days, (price_to_buy, buy_index)|
    possible_selling_prices = prices[(buy_index+1)..]
    possible_selling_prices.each_with_index do |price_to_sell, sell_index|
      current_profit = price_to_sell - price_to_buy
      max_profit = prices[buy_and_sell_price_days[1]] - prices[buy_and_sell_price_days[0]]
      if (current_profit > max_profit)
         buy_and_sell_price_days[0] = buy_index
         buy_and_sell_price_days[1] = buy_index + 1 + sell_index
      end
    end
    buy_and_sell_price_days
  end
end

p stock_picker([1,3,6,9,15,8,6,1,5])
