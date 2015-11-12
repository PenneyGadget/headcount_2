require_relative 'district_repository'
require_relative 'enrollment'
require_relative 'enrollment_parser'
require 'pry'


class EnrollmentRepository

  attr_reader :enrollments

  def initialize
    @enrollments = {}
  end

  def find_by_name(district)
    if @enrollments.keys.include?(district.to_s.upcase)
      return @enrollments[district.upcase]
    else
      return nil
    end
  end

  def load_data(hash)
    parser = EnrollmentParser.new
    hash.each do | k, v |
      if k == :enrollment
        parser.kindergarten_participation_parser(hash)
      end
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  er = EnrollmentRepository.new
  data = er.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})
end
