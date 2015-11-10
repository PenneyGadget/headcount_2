require_relative 'district'
require_relative 'parse'
require 'pry'

class DistrictRepository
  attr_reader :data, :districts

  def initialize
    @parser = Parse.new
    @data = {}
    @districts = []
  end

  def find_by_name(district)
    if @districts.include?(district.upcase)
      return district.upcase
    else
      return nil
    end
  end

  def find_all_matching(string)
    matches = @districts.collect do | d |
      d if d.include?(string.upcase)
    end
    matches.compact.length == 0 ? [] : matches.compact
  end

  def load_data(hash)
    key = hash.map{ |k, v| v.map{ |k, v| k }}.flatten[0]
    value = hash.map { |k, v| v.map { |k, v| v }}.flatten[0]
    populate_districts(value)
    @data[key] = @parser.parse(value)
  end

  def populate_districts(value)
    csv_table = @parser.parse(value)
    csv_table.each { |row| @districts << row[:location].upcase }
    @districts.uniq!
  end

end

dr = DistrictRepository.new
dr.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})
districts = dr.find_all_matching("ca")
puts districts
