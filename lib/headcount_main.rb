require 'pry'
require_relative 'enrollment'
require_relative 'enrollment_repository'
require_relative 'district_repository'
require_relative 'district'
require_relative 'headcount_analyst'

# dr = DistrictRepository.new
# ha = HeadcountAnalyst.new(dr)

er = EnrollmentRepository.new
er.load_data({
  :enrollment => {
    :kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv",
    :high_school_graduation => "./test/fixtures/High school graduation rates fixture.csv"
  }
})
enrollment = er.find_by_name("ACADEMY 20")
