require 'spec_helper'
require 'micexer/api'
include Micexer::Api

describe Micexer::Api do
  context "#api" do
    let(:board) { 'eqne' }
    let(:ticker) { 'gazp' }

    describe "trades" do
      use_vcr_cassette 'trades'

      it "should get data" do
        data = trades_from(43630)
        data.class.should == Array
        data.last.to_s.should == "{\"tradeno\"=>1622991360, \"tradetime\"=>2012-04-25 17:15:14 +0400, \"boardid\"=>\"EQNE\", \"secid\"=>\"GAZP\", \"price\"=>163.61, \"quantity\"=>145, \"buysell\"=>\"S\", \"share_id\"=>\"gazp\"}"
      end
    end

    describe "numtrades" do |variable|
      use_vcr_cassette 'numtrades'

      it "should get data" do
        numtrades.should == 43054
      end
    end
  end
  
  context "#urls" do
    let(:board) { 'board' }
    let(:ticker) { 'ticker' }
    let(:num) { Random.rand(0..100) }

    it "should compose numtrades_url" do
      numtrades_url.should == "http://www.micex.ru/" +
        "iss/engines/stock/markets/shares/boards/board/" +
        "securities/ticker.json" +
        "?marketdata.columns=NUMTRADES&iss.only=marketdata"
    end

    it "should compose trades_url" do
      trades_url(start_num: num).should == "http://www.micex.ru/" +
        "iss/engines/stock/markets/shares/boards/" +
        "board/securities/ticker/trades.json?" +
        "trades.columns=" +
        "TRADENO,TRADETIME,BOARDID,SECID,PRICE,QUANTITY,BUYSELL&start=#{num}"
    end

  end
end