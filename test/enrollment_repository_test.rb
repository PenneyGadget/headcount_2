require 'minitest/autorun'
require 'minitest/emoji'
require './lib/enrollment_repository'

class EnrollmentRepositoryTest < Minitest::Test

  def test_enrollment_repository_class_exists
    assert EnrollmentRepository.new
  end

  def test_find_by_name_method_returns_nil_with_an_invalid_name
    er = Enrollment.new

    assert_equal nil, er.find_by_name("puppies")
  end

  def test_find_by_name_method_returns_nil_with_an_integer
    er = Enrollment.new

    assert_equal nil, er.find_by_name(44)
  end

  def test_find_by_name_method_returns_an_enrollment_object
    er = Enrollment.new
    object = er.find_by_name("Colorado")

    assert_equal Enrollment, object.class
  end

  def test_find_by_name_is_case_insensitive
    er = Enrollment.new

    assert_equal "COLORADO", er.find_by_name("Colorado")
  end

  def test_load_data_method
    
  end

end
