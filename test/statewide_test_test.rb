require 'minitest/autorun'
require 'minitest/emoji'
require './lib/district_repository'

class StatewideTestTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
    @str = @dr.statewide_test_repo
    @str.load_data({:statewide_testing => {:third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
                                           :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
                                           :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
                                           :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
                                           :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
                                          }
                      })
    @statewide_test = @str.find_by_name("ACADEMY 20")
  end

  def test_enrollment_class_exists
    assert StatewideTest.new("stuff")
  end

  def test_truncate_number_method_works
    assert_equal 0.472, @statewide_test.truncate(0.4721894)
  end

  def test_name_method_returns_name
    assert_equal "ACADEMY 20", @statewide_test.name
  end

  def test_proficient_by_grade_method_takes_a_year_as_an_integer_and_returns_a_data_hash
    expected = {2008=>{:math=>0.857, :reading=>0.866, :writing=>0.671}, 
                2009=>{:math=>0.824, :reading=>0.862, :writing=>0.706}, 
                2010=>{:math=>0.849, :reading=>0.864, :writing=>0.662}, 
                2011=>{:math=>0.819, :reading=>0.867, :writing=>0.678}, 
                2012=>{:reading=>0.87, :math=>0.83, :writing=>0.655}, 
                2013=>{:math=>0.855, :reading=>0.859, :writing=>0.668}, 
                2014=>{:math=>0.834, :reading=>0.831, :writing=>0.639}}

    assert_equal expected, @statewide_test.proficient_by_grade(3)
  end

  def test_proficient_by_grade_raises_an_unknown_data_error_with_an_unknown_grade
    assert_raises "UnknownDataError" do
      @statewide_test.proficient_by_grade(6)
    end
  end

  def test_proficient_by_grade_raises_an_unknown_data_error_with_irrelevent_data
    assert_raises "UnknownDataError" do
      @statewide_test.proficient_by_grade("nachos!!")
    end
  end

  def test_proficient_by_race_or_ethnicity_method_takes_a_race_as_a_symbol_and_returns_a_data_hash
    expected = {2011=>{:math=>0.816, :reading=>0.897, :writing=>0.826}, 
                2012=>{:math=>0.818, :reading=>0.893, :writing=>0.808}, 
                2013=>{:math=>0.805, :reading=>0.901, :writing=>0.81}, 
                2014=>{:math=>0.8, :reading=>0.855, :writing=>0.789}}

    assert_equal expected, @statewide_test.proficient_by_race_or_ethnicity(:asian)
  end

  def test_proficient_by_race_raises_an_unknown_race_error_with_an_unknown_race
    assert_raises "UnknownRaceError" do
      @statewide_test.proficient_by_race_or_ethnicity(:alien)
    end
  end
  
  def test_proficient_by_race_raises_an_unknown_race_error_with_when_race_is_not_passed_in_as_a_symbol
    assert_raises "UnknownRaceError" do
      @statewide_test.proficient_by_race_or_ethnicity("black")
    end
  end

  def test_proficient_by_race_raises_an_unknown_race_error_with_irrelevent_data
    assert_raises "UnknownRaceError" do
      @statewide_test.proficient_by_race_or_ethnicity(1979)
    end
  end

  def test_race_or_ethnicity_is_valid_method_functions_properly
    assert_raises "UnknownRaceError" do
      @statewide_test.race_or_ethnicity_is_valid(:carebear)
    end
  end

  def test_query_hash_by_three_method_groups_data_correctly
    skip
    expected = {}
    assert_equal expected, @statewide_test.query_hash_by_three(@statewide_test.data, :timeframe, [{ :score => :data }])
  end

  def test_query_hash_by_three_with_race_by_subject_method_groups_data_correctly
    skip    
  end

end