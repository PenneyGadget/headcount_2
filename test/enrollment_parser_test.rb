require 'minitest/autorun'
require 'minitest/emoji'
require './lib/enrollment_parser'

class EnrollmentParserTest < Minitest::Test

  def test_enrollment_parser_exists
    assert EnrollmentParser.new
  end


end
