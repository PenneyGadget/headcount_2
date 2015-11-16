require 'pry'

require_relative 'district_repository'


dr = DistrictRepository.new

str = dr.statewide_test_repo
str.load_data({
  :statewide_testing => {
    :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
    :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
    :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
    :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
    :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
  }
})


puts dr.statewide_test_repo.find_by_name("ACADEMY 20").proficient_by_grade(3)
puts dr.statewide_test_repo.find_by_name("ACADEMY 20").proficient_by_race_or_ethnicity(:asian)














# dr.enrollment_repo.load_data({
#                               :enrollment => {
#                                               :kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"
#                                             }
#                               })

# dr.enrollment_repo.load_data({
#                               :enrollment => {
#                                               :kindergarten => "./data/Kindergartners in full-day program.csv",
#                                               :high_school_graduation => "./data/High school graduation rates.csv"
#                                             }
#                               })

# puts ha.kindergarten_participation_correlates_with_high_school_graduation(:for => "STATEWIDE")
# puts ha.kindergarten_participation_correlates_with_high_school_graduation(:across => ["Colorado", "ACADEMY 20", "Boulder Valley RE 2", "bethune r-5"])


#   {:name => "ACADEMY 20", :third_grade => 
#                                             [
#                                               {:location=>"Colorado", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.703"},
#                                               {:location=>"Colorado", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.726"},
#                                               {:location=>"Colorado", :score=>"Math", :timeframe=>"2014", :dataformat=>"Percent", :data=>"0.71589"}
#                                             ]
#   }