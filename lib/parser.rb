require 'csv'
require 'pry'

class Parser

  def parse(path)
    rows = CSV.open(path, {headers: true, header_converters: :symbol}).to_a
    hashes = rows.map { | r | r.to_hash }
    hashes.group_by { | h | h[:location] }
  end

end
