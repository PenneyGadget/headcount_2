require 'minitest/autorun'
require 'minitest/emoji'
require './lib/district_repository'
require './lib/parser'

class ParserTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
    @parser = Parser.new
  end

  def test_that_parser_exists
    assert Parser.new
  end

  def test_that_parser_groups_by_location
    by_location = @parser.parse("./test/fixtures/Kindergartners in full-day program fixture.csv")
    assert_equal [{:location=>"BRIGHTON 27J", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.2"}], by_location["BRIGHTON 27J"]
  end

end
