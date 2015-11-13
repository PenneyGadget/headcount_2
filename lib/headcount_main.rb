require 'pry'
require_relative 'enrollment'
require_relative 'enrollment_repository'
require_relative 'district_repository'
require_relative 'district'

# dr = DistrictRepository.new
#
# dr.enrollment_repo.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})
#
# puts dr.enrollment_repo.enrollments.first.kindergarten_participation_in_year(2006)

dr = DistrictRepository.new

dr.load_data({
  :enrollment => {
    :kindergarten => "./data/Kindergartners in full-day program.csv"
  }
})
district = dr.find_by_name("ACADEMY 20")

district.enrollment.kindergarten_participation_in_year(2010)
