require 'pry'
require_relative 'district_repository'

class Formatter

  def initialize(dr)
    @dr = dr
    @parser = Parser.new
    @formatters = {
                    :kindergarten => :kindergarten_formatter,
                    :high_school_graduation => :high_school_graduation_formatter
                  }
  end

  def distribute(hash)
    hash.each do | category, v |
      hash[category].each do | tag, path |
        formatted = call_formatter(tag, @parser.parse(path))
        formatted.each do | formatted_hash |
          package(category, formatted_hash)
        end
      end
    end
  end

  def call_formatter(tag, parsed_data)
    method(@formatters[tag]).call(parsed_data)
  end

  def package(category, formatted_hash)
    if category == :enrollment
      @dr.enrollment_repo.store_enrollment(formatted_hash)
    end
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

  def kindergarten_formatter(parsed_data)
    prepped_hashes = parsed_data.map do | dist_name, dist_rows |
      {:name => dist_name,
       :kindergarten_participation => extract_years_from_district_rows(dist_rows)}
    end
    prepped_hashes
  end

  def high_school_graduation_formatter(parsed_data)
    prepped_hashes = parsed_data.map do | dist_name, dist_rows |
      {:name => dist_name,
       :high_school_graduation => extract_years_from_district_rows(dist_rows)}
    end
    prepped_hashes
  end

end