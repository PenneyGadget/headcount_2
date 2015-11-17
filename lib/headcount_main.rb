require 'pry'

require_relative 'district_repository'


dr = DistrictRepository.new
ha = HeadcountAnalyst.new(dr)
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

puts ha.top_statewide_test_year_over_year_growth(grade: 3, subject: :math)