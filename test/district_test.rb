require 'minitest/autorun'
require 'minitest/emoji'
require './lib/district_repository'

class DistrictTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
    @dr.load_data({ :enrollment =>
                    { :kindergarten =>           "./data/Kindergartners in full-day program.csv",
                      :high_school_graduation => "./data/High school graduation rates.csv"
                    }
                  })
  end

  def test_district_class_exists
    assert District.new("Colorado")
  end

  def test_name_method_return_the_upcased_string_name_of_district
    d = District.new("Colorado")

    assert_equal "COLORADO", d.name
  end

  def test_set_enrollment_method_returns_an_enrollment_object
    assert_equal Enrollment, @dr.find_by_name("Colorado").enrollment.class
  end

end
