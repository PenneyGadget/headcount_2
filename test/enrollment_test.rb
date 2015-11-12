require 'minitest/autorun'
require 'minitest/emoji'
require './lib/enrollment'

class EnrollmentTest < Minitest::Test

  def test_enrollment_class_exists
    assert Enrollment.new
  end

  def test_truncate_number_method_works
    skip
    e = Enrollment.new()

  end

end
