require 'minitest/autorun'
require 'minitest/pride'
require './lib/parse'

class ParseTest < Minitest::Test

  def test_parse_class_exists
    assert Parse.new
  end

end
