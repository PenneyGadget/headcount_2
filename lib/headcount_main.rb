require 'pry'

require_relative 'district_repository'


dr = DistrictRepository.new
ha = HeadcountAnalyst.new(dr)
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

puts ha.kindergarten_participation_correlates_with_high_school_graduation(:for => "STATEWIDE")
puts ha.kindergarten_participation_correlates_with_high_school_graduation(:across => ["Colorado", "ACADEMY 20", "Boulder Valley RE 2", "bethune r-5"])