require_relative 'district_repository'
require_relative 'enrollment'
require_relative 'enrollment_parser'
require 'pry'


class EnrollmentRepository

  attr_reader :dr, :enrollments

  def initialize(dr = nil)
    @enrollments = {}
    @dr = dr
  end

  def store_enrollment(district, file_key, enrollment)
    merger = { district => { file_key => enrollment } }
    @enrollments = @enrollments.merge(merger)
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
        parser.parser(hash)
      end
    end
  end

end
