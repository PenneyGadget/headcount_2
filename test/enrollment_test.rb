require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment'

class EnrollmentTest < Minitest::Test

  def test_enrollment_class_exists
    assert Enrollment.new
  end

end
