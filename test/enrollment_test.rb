require 'minitest/autorun'
require 'minitest/emoji'
require './lib/enrollment'

class EnrollmentTest < Minitest::Test

  def setup
    @data = {:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}}
  end

  def test_enrollment_class_exists
    assert Enrollment.new(setup)
  end

  def test_truncate_number_method_works
    e = Enrollment.new(setup)

    assert_equal 0.472, e.truncate(0.4721894)
  end

  def test_name_method_returns_name
    e = Enrollment.new(setup)

    assert_equal "ACADEMY 20", e.name
  end

  def test_kindergarten_participation_by_year_returns_a_data_hash_with_3_digit_floats
    e = Enrollment.new(setup)
    expected = {2010=>0.391, 2011=>0.353, 2012=>0.267}

    assert_equal expected, e.kindergarten_participation_by_year
  end

  def test_kindergarten_participation_in_year_returns_a_3_digit_float
    e = Enrollment.new(setup)

    assert_equal 0.353, e.kindergarten_participation_in_year(2011)
  end

  def test_kindergarten_participation_in_year_returns_nil_with_an_unknown_year
    e = Enrollment.new(setup)

    assert_equal nil, e.kindergarten_participation_in_year(2008)
  end

end
