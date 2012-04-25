require 'csv'

module Micexer
  module File

    def parse_csv_file
      collection = []
      options = { col_sep: ';' }
      csv = CSV.parse(::File.read(self.file), options)
      csv.each_with_index do |row, index|
        next if (0..2).include?(index)
        collection << read_row(row) if appropriate?(row)
      end
      collection
    end

    def appropriate?(row)
      row[3].downcase == self.ticker.downcase
    end

    def read_row(row)
      {}.tap do |item|
        item['tradeno']    = row[0]
        item['tradetime']  = Time.parse([row[1..2]].join(' '))
        item['share_id']   = row[3].downcase
        item['secid']      = row[3]
        item['boardid']    = row[4]
        item['price']      = row[5].sub(',','.').to_f
        item['quantity']   = row[6].to_i
        item['buysell']    = row[9]
      end
    end

  end
end
