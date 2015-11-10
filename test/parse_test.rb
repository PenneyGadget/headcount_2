require 'minitest/autorun'
require 'minitest/emoji'
require './lib/parse'

class ParseTest < Minitest::Test

  def test_parse_class_exists
    assert Parse.new
  end

end
