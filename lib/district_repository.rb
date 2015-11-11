require_relative 'district'
require_relative 'enrollment_repository'
require_relative 'statewide_testing_repository'
require_relative 'economic_profile_repository'
require_relative 'parse'
require 'pry'

class DistrictRepository
  attr_reader :data, :districts

  def initialize
    @parser = Parse.new
    @districts = {}
    @enrollment_repo = EnrollmentRepository.new
    @statewide_testing_repo = StatewideTestingRepository.new
    @economic_profile_repo = EconomicProfileRepository.new
    build_districts
  end

  def build_districts
    CSV.open("./data/Kindergartners in full-day program.csv", headers: true).each do |row|
      if @districts.keys.include?(row["Location"].upcase)
        next
      else
        row_data = {row["Location"].upcase => District.new(row["Location"].upcase)}
        @districts = @districts.merge(row_data)
      end
    end
  end

  def find_by_name(district)
    if @districts.keys.include?(district.to_s.upcase)
      return @districts[district.upcase]
    else
      return nil
    end
  end

  def find_all_matching(string)
    matches = @districts.map do | name, object |
      name if name.include?(string.to_s.upcase)
    end
    matches.length == 0 ? [] : matches.compact
  end

  def load_data(hash)
    hash.each_key do | k |
      @enrollment_repo.load_data(hash[k]) if k == :enrollment
      @statewide_testing_repo.load_data(hash[k]) if k == :statewide_testing
      @economic_profile_repo.load_data(hash[k]) if k == :economic_profile
    end
  end

end
