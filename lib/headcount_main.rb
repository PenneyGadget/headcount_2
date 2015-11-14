require 'pry'
require_relative 'district_repository'


dr = DistrictRepository.new

# dr.enrollment_repo.load_data({
#                               :enrollment => {
#                                               :kindergarten => "./data/Kindergartners in full-day program.csv"
#                                             }
#                               })

dr.enrollment_repo.load_data({
                              :enrollment => {
                                              :kindergarten => "./data/Kindergartners in full-day program.csv",
                                              :high_school_graduation => "./data/High school graduation rates.csv"
                                            }
                              })