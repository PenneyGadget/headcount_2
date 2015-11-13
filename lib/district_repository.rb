require_relative 'district'
require_relative 'enrollment_repository'
require_relative 'statewide_testing_repository'
require_relative 'economic_profile_repository'
require 'pry'

class DistrictRepository
  attr_reader :districts, :enrollment_repo, :statewide_testing_repo, :economic_profile_repo

  def initialize
    @districts = []
    @enrollment_repo = EnrollmentRepository.new(self)
    @statewide_testing_repo = StatewideTestingRepository.new(self)
    @economic_profile_repo = EconomicProfileRepository.new(self)
    build_districts
  end

  def build_districts
    CSV.open("./data/Kindergartners in full-day program.csv", headers: true).each do |row|
      if find_by_name(row["Location"].upcase) == true
        next
      else
        @districts << District.new(row["Location"].upcase)
      end
    end
  end

  def find_by_name(district)
    @districts.each do | d |
      if d.name == district.upcase
        return d
      end
    end
    return nil
  end

  def find_all_matching(string)
    matches = @districts.map do | d |
      d if d.name.include?(string.to_s.upcase)
    end
    matches.length == 0 ? [] : matches.compact
  end

  def load_data(hash)
    hash.each_key do | k |
      @enrollment_repo.load_data(hash) if k == :enrollment
      @statewide_testing_repo.load_data(hash) if k == :statewide_testing
      @economic_profile_repo.load_data(hash) if k == :economic_profile
    end
  end

end
