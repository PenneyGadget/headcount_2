require 'csv'
require 'pry'
require_relative 'district'

class Parse

  def initialize(path_name)
    CSV.read(path_name, headers: true, header_converters: :symbol).each do |row|
      if row[:location] == 'ACADEMY 20'
        district = District.new
        district.enrollment = row[:data]
        data << district
      end
    end
    binding.pry
  end

end

Parse.new("../data/Pupil enrollment.csv")
