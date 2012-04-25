require 'micexer/api/url_helper'

module Micexer
  module Api
    include UrlHelper

    FIELDS  = %w( TRADENO TRADETIME BOARDID SECID PRICE QUANTITY BUYSELL )

    def trades_from(num)
      url      = trades_url(start_num: num)
      response = response(url)
      if response.code == '200'
        body = JSON(response.body)
        if body['trades']['data'].size > 0
          return prepare_collection body
        end
      end
      nil
    end

    def numtrades
      @numtrades ||= begin
        request_url = numtrades_url
        response    = response(request_url)
        if response.code == "200"
          body = JSON(response.body)
          body['marketdata']['data'].to_s.gsub(/[\[\]]/,'').to_i
        else
          0
        end
      end
    end

    def prepare_collection(body)
      body['trades']['data'].map do |row|
        {}.tap do |item|
          FIELDS.each_with_index do |attribute, ind|
            item[attribute.downcase] = row[ind]
          end
          item['share_id']  = self.ticker
          item['tradetime'] = Time.parse(item['tradetime'])
        end
      end
    end

  end
end