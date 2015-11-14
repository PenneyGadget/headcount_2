require 'minitest/autorun'
require 'minitest/emoji'
require './lib/district_repository'
require './lib/enrollment'

class EnrollmentTest < Minitest::Test

  def setup
    @data = {:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}}
    @enrollment = Enrollment.new(@data)
  end

  def test_enrollment_class_exists
    assert Enrollment.new(@data)
  end

  def test_truncate_number_method_works
    assert_equal 0.472, @enrollment.truncate(0.4721894)
  end

  def test_name_method_returns_name
    assert_equal "ACADEMY 20", @enrollment.name
  end

  def test_kindergarten_participation_by_year_returns_a_data_hash_with_3_digit_floats
    expected = {2010=>0.391, 2011=>0.353, 2012=>0.267}

    assert_equal expected, @enrollment.kindergarten_participation_by_year
  end

  def test_kindergarten_participation_in_year_returns_a_3_digit_float
    assert_equal 0.353, @enrollment.kindergarten_participation_in_year(2011)
  end

  def test_kindergarten_participation_in_year_returns_nil_with_an_unknown_year
    assert_equal nil, @enrollment.kindergarten_participation_in_year(2008)
  end

end
