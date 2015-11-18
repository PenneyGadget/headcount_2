require 'pry'
require_relative 'district_repository'

class EconomicProfile

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def name
    @data[:name]
  end

  def estimated_median_household_income_in_year(year)
    fail UnknownDataError unless year_is_valid_with_range(year)
    data_for_years = @data[:median_household_income].map do | hash_row |
      hash_row[:data].to_i if get_year_range(hash_row[:timeframe]).include?(year)
    end
    data_for_years = data_for_years.compact
    data_for_years.compact.reduce(:+)/data_for_years.length
  end

  def median_household_income_average
    data_for_years = @data[:median_household_income].map do | hash_row |
      hash_row[:data].to_i
    end
    data_for_years = data_for_years.compact
    data_for_years.compact.reduce(:+)/data_for_years.length
  end

  # I hate you git.

  def children_in_poverty_in_year(year)
  end

  def free_or_reduced_price_lunch_percentage_in_year(year)
  end

  def free_or_reduced_price_lunch_number_in_year(year)
  end

  def title_i_in_year(year)
  end

  def year_is_valid_with_range(year)
    @data[:median_household_income].any? do | hash_row |
      year_range = get_year_range(hash_row[:timeframe])
      year_range.include?(year)
    end
  end

  def get_year_range(timeframe)
    years = timeframe.split("-")
    (years[0].to_i..years[1].to_i)
  end

  def truncate(number)
    (number.to_f * 1000.0).to_i / 1000.0
  end

end