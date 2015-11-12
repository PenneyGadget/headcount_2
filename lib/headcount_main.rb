require 'pry'
require_relative 'enrollment'
require_relative 'enrollment_repository'
require_relative 'district_repository'
require_relative 'district'

dr = DistrictRepository.new

p = EnrollmentParser.new(dr.enrollment_repo)
p.parser({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})

er = EnrollmentRepository.new
data = er.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})

er.enrollments["ACADEMY 20"]["kindergarten_participation"].kindergarten_participation_by_year
