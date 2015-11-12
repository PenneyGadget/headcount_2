require 'csv'
require 'pry'
require_relative 'enrollment'

class EnrollmentParser

  def kindergarten_participation_parser(hash)
    kp = :kindergarten_participation
    enrollments = {:location => "", kp => {}}
    merger = {:location => ""}
    hash.each do |key, val|
      hash[key].each do |key2, val2|
        CSV.read(val2, {headers: true, header_converters: :symbol}).each do |line|
          enrollments[:location] = line[:location]
          merger[kp] = {line[:timeframe] => line[:data]}
          enrollments[kp] = enrollments[kp].merge(merger[kp]){|k, v1, v2| v1.merge(v2)}
        end
      end
    end
  end

end

  # def truncate(number)
  #   (number.to_f * 1000).to_i / 1000.0
  # end

p = EnrollmentParser.new
data = p.kindergarten_participation_parser({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})


# enrollments[:location] = line[:location]
# enrollments[:timeframe] = line[:timeframe]
# enrollments[:data] = line[:data]
