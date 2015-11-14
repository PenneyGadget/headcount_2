require 'pry'
require_relative 'district_repository'


dr = DistrictRepository.new

# dr.enrollment_repo.load_data({
#                               :enrollment => {
#                                               :kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"
#                                             }
#                               })

dr.enrollment_repo.load_data({
                              :enrollment => {
                                              :kindergarten => "./data/Kindergartners in full-day program.csv",
                                              :high_school_graduation => "./data/High school graduation rates.csv"
                                            }
                              })

dr.enrollment_repo.enrollments.each do |enrollment|
  puts enrollment.data
end