require 'minitest/autorun'
require 'minitest/emoji'
require './lib/enrollment_parser'

class EnrollmentParserTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
    @parser = EnrollmentParser.new(@dr.enrollment_repo)
    @parser.parser({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})
  end

  def test_enrollment_parser_exists
    assert EnrollmentParser.new("stuff")
  end

  def test_extract_years_method_extract_raw_data
    assert_equal({"2007"=>"0.39465"}, @parser.extract_years_from_district_rows([{:location=>"Colorado", :timeframe=>"2007", :dataformat=>"Percent", :data=>"0.39465"}]))
  end

  def test_parser_stores_all_unique_districts
    assert_equal 11, @dr.enrollment_repo.enrollments.length
  end

end
