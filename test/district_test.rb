require 'minitest/autorun'
require 'minitest/pride'
require './lib/district'

class DistrictTest < Minitest::Test

  def test_district_class_exists
    assert District.new
  end

end
