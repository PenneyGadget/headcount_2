require 'minitest/autorun'
require 'minitest/emoji'
require './lib/district_repository'
require './lib/headcount_analyst'

class HeadcountAnalystTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
    @ha = HeadcountAnalyst.new(@dr)
    @dr.load_data({ :enrollment =>
                    { :kindergarten =>           "./data/Kindergartners in full-day program.csv",
                      :high_school_graduation => "./data/High school graduation rates.csv"
                    }
                  })
  end

  def test_headcount_class_exists
    assert HeadcountAnalyst.new("stuff")
  end

  def test_kindergarten_participation_rate_variation_compares_two_districts_and_returns_a_3_digit_float
    assert_equal 0.766, @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
  end

  def test_kindergarten_participation_rate_variation_trend_returns_a_hash_with_years_and_three_digit_floats
    assert_equal({"2007"=>0.992, "2006"=>1.05,
                  "2005"=>0.96,  "2004"=>1.257,
                  "2008"=>0.717, "2009"=>0.652,
                  "2010"=>0.681, "2011"=>0.727,
                  "2012"=>0.688, "2013"=>0.694, "2014"=>0.661}, @ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO'))
  end

  def test_get_kp_data_grabs_the_proper_raw_data
    assert_equal [0.21756, 0.11923, 0.35254,
                  0.30224, 0.7658, 0.98,
                  0.99327, 0.993, 1.0, 1.0, 1.0], @ha.get_kp_data(@dr.find_by_name("CANON CITY RE-1"))
  end

  def test_get_kp_data_with_year_grabs_the_proper_raw_data
    assert_equal({"2007"=>0.21756, "2006"=>0.11923, "2005"=>0.35254,
                  "2004"=>0.30224, "2008"=>0.7658, "2009"=>0.98,
                  "2010"=>0.99327, "2011"=>0.993, "2012"=>1.0, "2013"=>1.0, "2014"=>1.0}, @ha.get_kp_data_with_year(@dr.find_by_name("CANON CITY RE-1")))
  end

  def test_get_avg_method_does_the_maths_right
    data = [2.01, 5.0, 7.64, 11.92]

    assert_equal 6.6425, @ha.get_avg(data)
  end

  def test_truncate_method_also_does_the_math_thing_correctly
    number = 0.38759

    assert_equal 0.387, @ha.truncate(number)
  end

end
