require 'csv'
require 'pry'
require_relative 'enrollment'
require_relative 'enrollment_repository'
require_relative 'district_repository'

class EnrollmentParser

  attr_reader :enrollment_repo

  def initialize(enrollment_repo)
    @enrollment_repo = enrollment_repo
  end

  def parser(hash)
    enrollments = {:name => "", :kindergarten_participation => {} }
    hash.each do |key, val|
      hash[key].each do |key2, val2|
        CSV.read(val2, {headers: true, header_converters: :symbol}).each do |row|
          if enrollments[:name] == row[:location] || enrollments[:name] == ""
            enrollments[:name] = row[:location]
            enrollments[:kindergarten_participation][row[:timeframe]] = row[:data]
          else
            binding.pry
            enrollment_repo.store_enrollment(enrollments[:name], :kindergarten_participation, Enrollment.new(enrollments))
            enrollments[:name] = row[:location]
            enrollments[:kindergarten_participation] = {}
            enrollments[:kindergarten_participation][row[:timeframe]] = row[:data]
          end
        end
      end
    end
  end

end
