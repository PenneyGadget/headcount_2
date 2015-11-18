require 'pry'

require_relative 'district_repository'


dr = DistrictRepository.new
ha = HeadcountAnalyst.new(dr)
str = dr.statewide_test_repo
epr = dr.economic_profile_repo

epr.load_data({
    :economic_profile => {
                          :median_household_income => "./data/Median household income.csv",
                          :children_in_poverty => "./data/School-aged children in poverty.csv",
                          :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
                          :title_i => "./data/Title I students.csv"
  }
})
ep = epr.find_by_name("ACADEMY 20")