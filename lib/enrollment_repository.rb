require 'pry'
require_relative 'district_repository'

class EnrollmentRepository

  attr_reader :enrollments

  def initialize(dr = nil)
    @enrollments = []
    @dr = dr
  end

  def store_enrollment(data)
    enroll = Enrollment.new(data)
    @dr.find_by_name(enroll.name).set_enrollment(enroll)
    @enrollments << enroll
  end

  def find_by_name(district)
    @enrollments.each do |enrollment|
      return enrollment if enrollment.name.upcase == district.to_s.upcase
    end
    nil
  end

  def load_data(hash)
    @dr.formatter.distribute(hash)
  end

end
