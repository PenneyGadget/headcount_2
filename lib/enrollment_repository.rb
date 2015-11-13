require_relative 'district_repository'
require_relative 'enrollment'
require_relative 'enrollment_parser'
require 'pry'


class EnrollmentRepository

  attr_reader :enrollments

  def initialize
    @enrollments = []
  end

  def store_enrollment(data)
    e = Enrollment.new(data)
    @enrollments << Enrollment.new(data)
  end

  def find_by_name(district)
    @enrollments.select do |enrollment|
      enrollment.name == district
    end
  end

  def load_data(hash)
    parser = EnrollmentParser.new(self)
    hash.each do | k, v |
      if k == :enrollment
        parser.parser(hash)
      end
    end
  end

end
