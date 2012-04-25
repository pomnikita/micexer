require 'spec_helper'
require 'micexer/file'
include Micexer::File

describe Micexer::File do
  context "#csv" do
    let(:file) { File.expand_path('../../fixtures/trades.csv', __FILE__) }
    let(:board) { 'eqne' }
    let(:ticker) { 'gazp' }

    it "should read file" do
      collection = parse_csv_file
      collection.size.should == 370
      collection.map{ |t| t['share_id'] }.uniq.should == [ticker]
      collection.last.to_s.should == "{\"tradeno\"=>\"1268523268\", \"tradetime\"=>2011-07-19 18:49:59 +0400, \"share_id\"=>\"gazp\", \"secid\"=>\"GAZP\", \"boardid\"=>\"EQNE\", \"price\"=>199.76, \"quantity\"=>50, \"buysell\"=>\"S\"}"
    end
  end
end