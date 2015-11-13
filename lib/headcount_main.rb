require 'pry'
require_relative 'enrollment'
require_relative 'enrollment_repository'
require_relative 'district_repository'
require_relative 'district'

dr = DistrictRepository.new

dr.enrollment_repo.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})

dr.enrollment_repo.enrollments.each do |enrollment|
  puts "Individual enrollment: #{enrollment} with data : #{enrollment.data}"
end

#p = EnrollmentParser.new(dr.enrollment_repo)
#p.parser({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})

# dr.enrollment_repo.enrollments.each do |enrollment|
#   puts "Name: #{enrollment.name}"
#   puts "Data: #{enrollment.data}"
#   puts "*************************"
# end
