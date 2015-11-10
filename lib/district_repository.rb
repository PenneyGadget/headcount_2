require_relative 'district'
require_relative 'parse'
require 'pry'

class DistrictRepository
  attr_reader :data

  def initialize
    @parser = Parse.new
    @data = {}
  end

  def find_by_name(district)
    csv_table = @data[:kindergarten]
    csv_table.each do |row|
      if row[:location] == district
        puts row[:location]
      end
    end

  end

  def find_all_matching

  end

  def load_data(hash)
    key = hash.map{ |k, v| v.map{ |k, v| k }}.flatten[0]
    value = hash.map { |k, v| v.map { |k, v| v }}.flatten[0]
    @data[key] = @parser.parse(value)
  end

end

dr = DistrictRepository.new
dr.load_data({:enrollment => {:kindergarten => "../test/fixtures/Kindergartners in full-day program fixture.csv"}})
district = dr.find_by_name("ACADEMY 20")
