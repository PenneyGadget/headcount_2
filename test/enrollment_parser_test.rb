require 'minitest/autorun'
require 'minitest/emoji'
require './lib/enrollment_parser'

class EnrollmentParserTest < Minitest::Test

  def test_enrollment_parser_exists
    assert EnrollmentParser.new
  end

  def test_parser_returns_an_enrollment_object
    skip
    ep = EnrollmentParser.new
    object = ep.kindergarten_participation_parser({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})

    assert_equal Enrollment, object.class
  end

end
