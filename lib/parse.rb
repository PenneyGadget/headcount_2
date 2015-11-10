require 'csv'
require 'pry'
require_relative 'district'

class Parse

  def parse(path_name)
    CSV.read(path_name, {headers: true, header_converters: :symbol})
  end

end
