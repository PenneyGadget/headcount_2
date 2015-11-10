require 'minitest/autorun'
require 'minitest/emoji'
require './lib/district'

class DistrictTest < Minitest::Test

  def test_district_class_exists
    assert District.new({:name => "Colorado"})
  end

  def test_name_method_return_the_upcased_string_name_of_district
    d = District.new({:name => "Colorado"})

    assert_equal "COLORADO", d.name
  end

end
