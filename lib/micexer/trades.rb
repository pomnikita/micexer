require 'micexer/api'
require 'micexer/file'

module Micexer
  class Trades
    include Api
    include File

    attr_reader :ticker, :board, :last_trade_num, :file, :collection

    def initialize(ticker, board, options = {})
      @ticker, @board = ticker, board
      @collection = []
      @last_trade_num = options[:last_trade_num] || 0
      @file = options[:file] || nil
    end

    def load_collection_with_api!
      trades = []
      return [] if numtrades == 0
      (@last_trade_num..numtrades/5000).each do |i|
        trades << trades_from(5000*i)
      end
      @collection = trades.compact.flatten
    end

    def load_collection_from_csv!
      return [] unless @file
      @collection = parse_csv_file
    end

  end
end