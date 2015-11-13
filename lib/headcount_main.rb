require 'pry'
require_relative 'enrollment'
require_relative 'enrollment_repository'
require_relative 'district_repository'
require_relative 'district'
require_relative 'headcount_analyst'

dr = DistrictRepository.new
ha = HeadcountAnalyst.new(dr)

dr.enrollment_repo.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})

puts ha.kindergarten_participation_rate_variation_trend("ACADEMY 20", :against => "COLORADO")
