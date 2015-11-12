require 'minitest/autorun'
require 'minitest/emoji'
require './lib/enrollment'

class EnrollmentTest < Minitest::Test

  def setup
    @data = {:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}}
  end

  def test_enrollment_class_exists
    assert Enrollment.new(data)
  end

  def test_truncate_number_method_works
    skip
    e = Enrollment.new()

  end

  def test_kindergarten_participation_by_year_returns_a_data_hash_with_3_digit_floats

  end

  def test_kindergarten_participation_in_year_returns_a_3_digit_float

  end

  def test_kindergarten_participation_in_year_returns_nil_with_an_unknown_year

  end

end
