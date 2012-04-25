require 'net/http'
require 'json'

module Micexer
  module Api
    module UrlHelper
      API_URL = "http://www.micex.ru/iss/engines/stock/markets/shares/boards"

      def response(url)
        Net::HTTP.get_response URI.parse(url)
      end

      def numtrades_url
        data_url  = [ticker_url, "json"].join('.')
        [data_url, numtrades_params].join('?')
      end

      def trades_url(options = {})
        start_num = options[:start_num] || 0
        data_url  = [ticker_url, 'trades.json'].join('/')

        [data_url, request_params(start_num)].join('?')
      end

      def ticker_url
        [API_URL, "#{self.board}/securities/#{self.ticker}"].join('/')
      end

      def numtrades_params
        "marketdata.columns=NUMTRADES&iss.only=marketdata"
      end

      def request_params(start_num)
        "trades.columns=#{Api::FIELDS.join(',')}&start=#{start_num}"
      end

    end
  end
end