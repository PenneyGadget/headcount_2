require 'minitest/autorun'
require 'minitest/emoji'
require './lib/district_repository'
require './lib/formatter'

class FormatterTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
    @dr.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})
    @formatter = Formatter.new(@dr)
  end

  def test_that_distribute_works
    skip
  end

  def test_that_find_formatter_works
    skip
  end

  def test_that_package_works
    skip
  end

  def test_that_extract_years_method_extracts_raw_data
    assert_equal({"2007"=>"0.39465"}, @formatter.extract_years_from_district_rows([{:location=>"Colorado", :timeframe=>"2007", :dataformat=>"Percent", :data=>"0.39465"}]))
  end

  def test_package_stores_all_unique_districts
    assert_equal 11, @dr.enrollment_repo.enrollments.length
  end

end