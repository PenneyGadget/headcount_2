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


  def extract_years_from_district_rows(rows)
    years = {}
    rows.each do |hash|
      year = hash[:timeframe]
      data = hash[:data]
      years[year] = data
    end
    years
  end

  def parser(hash)
    filepath = hash[:enrollment][:kindergarten]
    rows = CSV.open(filepath, {headers: true, header_converters: :symbol}).to_a
    hashes = rows.map { |r| r.to_hash }
    grouped = hashes.group_by { |h| h[:location] }
    prepped_hashes = grouped.map do |district_name, district_rows|
      {:name => district_name,
       :kindergarten_participation => extract_years_from_district_rows(district_rows)
      }
    end
    prepped_hashes.each do |h|
      enrollment_repo.store_enrollment(h)
    end
  end

end
