require 'micexer/trades'

module Micexer
  module Chart
    MAX_SIZE = 60000

    extend self

    def data(ticker, board)
      trades = Trades.new(ticker, board).load_collection_with_api!
      return if trades.empty?
      prices, values = load_data_from(trades)
      truncate(prices, values)
    end

    def load_data_from(trades)
      prices = extract_prices_from(trades)
      values = extract_values_from(trades)
      [prices, values]
    end

    private

    def truncate(*data)
      data.map do |array|
        (0..array.size - 1).select do |i|
          select_by_index_from?(array, i)
        end.map{ |index| array[index] }
      end
    end

    def select_by_index_from?(array, index)
      quotion = array.size / MAX_SIZE.to_f
      if quotion > 2
        index % quotion.round == 0
      elsif quotion > 1
        index % 2 != 0
      else
        true
      end
    end

    def extract_prices_from(trades)
      trades.map { |t| t['price'] }
    end

    def extract_values_from(trades)
      values = [0]
      trades.each do |trade|
        values << values.last + net_value_for(trade)
      end
      values
    end

    def net_value_for(trade)
      sign = trade['buysell'] == 'B' ? 1 : -1
      trade['price'] * trade['quantity'] * sign
    end

  end
end