require 'minitest/autorun'
require 'minitest/emoji'
require './lib/enrollment_repository'

class EnrollmentRepositoryTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
    @dr.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})
    @er = @dr.enrollment_repo
  end

  def test_enrollment_repository_class_exists
    assert @er
  end

  def test_enrollment_repository_is_initialized_with_an_empty_enrollment_array
    er = EnrollmentRepository.new

    assert_equal [], er.enrollments
  end

  def test_enrollment_repository_is_initialized_with_our_districts
    dr = DistrictRepository.new

    assert dr.enrollment_repo
    assert_equal EnrollmentRepository, dr.enrollment_repo.class
  end

  def test_store_enrollment_method_stores_our_enrollment_objects
    assert_equal Enrollment, @er.enrollments[0].class

    assert_equal "DELTA COUNTY 50(J)", @er.enrollments[-2].name

    assert_equal({:name=>"GUNNISON WATERSHED RE1J",
                  :kindergarten_participation=>{"2006"=>"0.13514"}}, @er.enrollments[-1].data)
  end

  def test_first_and_last_enrollment_objects_are_not_the_same_object
    refute_equal @er.enrollments[0].data, @er.enrollments[-1].data
  end

  def test_find_by_name_method_returns_nil_with_an_invalid_name
    assert_equal nil, @er.find_by_name("puppies")
  end

  def test_find_by_name_method_returns_nil_with_an_integer
    assert_equal nil, @er.find_by_name(44)
  end

  def test_find_by_name_method_returns_an_enrollment_object
    object = @er.find_by_name("Colorado")

    assert_equal Enrollment, object.class
  end

  def test_find_by_name_is_case_insensitive
    assert_equal "Colorado", @er.find_by_name("ColORADo").name
  end

  def test_load_data_method_chooses_the_correct_key
    assert_equal [:enrollment], @er.load_data({:enrollment =>
                                              {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}}).keys
  end

end
