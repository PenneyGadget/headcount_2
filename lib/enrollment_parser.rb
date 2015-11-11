require 'csv'
require 'pry'
require_relative 'enrollment'

class EnrollmentParser

  def parse(hash)
    enrollments = {}
    hash.each do |key, val|
      hash[key].each do |key2, val2|
        CSV.read(val2, {headers: true, header_converters: :symbol}).each do |line|
          enrollments[:location] = line[:location]
          enrollments[:timeframe] = line[:timeframe]
          enrollments[:data] = line[:data]
          return Enrollment.new(enrollments)
        end
      end
    end
  end

  # def truncate(number)
  #   (number.to_f * 1000).to_i / 1000.0
  # end

end

# p = EnrollmentParser.new
# data = p.parse('./test/fixtures/Kindergartners in full-day program fixture.csv')
