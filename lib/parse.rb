require 'csv'
require 'pry'
require_relative 'district'

class Parse

  def parse(path_name)
    CSV.read(path_name, {headers: true, header_converters: :symbol})
  end

end


# Parse.new("../data/Pupil enrollment.csv")

# if row[:location] == 'ACADEMY 20'
#   district = District.new
#   district.enrollment = row[:data]
#   data << district
# end
