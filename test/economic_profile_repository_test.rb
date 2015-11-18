require 'minitest/autorun'
require 'minitest/emoji'
require './lib/district_repository'

class EconomicProfileRepositoryTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
    @epr = @dr.enrollment_repo
    @epr.load_data({:economic_profile => { :median_household_income => "./data/Median household income.csv",
                                           :children_in_poverty => "./data/School-aged children in poverty.csv",
                                           :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
                                           :title_i => "./data/Title I students.csv" }})
    @economic_profile = @epr.find_by_name("ACADEMY 20")
  end

  def test_economic_profile_repository_class_exists
    assert @epr
  end

  def test_economic_profile_repository_is_initialized_with_an_empty_economic_profile_array
    epr = EconomicProfileRepository.new

    assert_equal [], epr.economic_profiles
  end

  def test_economic_profile_repository_is_initialized_with_our_district_repo
    dr = DistrictRepository.new

    assert dr.economic_profile_repo
    assert_equal EconomicProfileRepository, dr.economic_profile_repo.class
  end

  def test_store_economic_profiles_method_stores_our_economic_profile_objects_for_multiple_files
    assert_equal EconomicProfile, @er.economic_profiles[0].class
    assert_equal "WRAY SCHOOL DISTRICT RD-2", @epr.economic_profiles[-2].name

    assert_equal({:name => "YUMA SCHOOL DISTRICT 1",
                  :median_household_income => { 2007=>1, 2006=>1, 2005=>1,
                                                2004=>0, 2008=>1, 2009=>1,
                                                2010=>1, 2011=>1, 2012=>1,
                                                2013=>1, 2014=>1 },
                  :children_in_poverty =>     { 2010=>0.903, 2011=>0.891,
                                                2012=>0.85455, 2013=>0.88333,
                                                2014=>0.91 },
                  :free_or_reduced_price_lunch =>     { 2010=>0.903, 2011=>0.891,
                                                2012=>0.85455, 2013=>0.88333,
                                                2014=>0.91 },
                  :title_i =>     { 2010=>0.903, 2011=>0.891,
                                                2012=>0.85455, 2013=>0.88333,
                                                2014=>0.91 }
                  }, @epr.economic_profiles[-1].data)
  end

  def test_first_and_last_economic_profile_objects_are_not_the_same_object
    refute_equal @epr.economic_profile[0].object_id, @epr.economic_profile[-1].object_id
  end

  def test_find_by_name_method_returns_nil_with_an_invalid_name
    assert_equal nil, @epr.find_by_name("horacepalooza")
  end

  def test_find_by_name_method_returns_nil_with_an_integer
    assert_equal nil, @epr.find_by_name(44)
  end

  def test_find_by_name_method_returns_an_economic_profile_object
    object = @epr.find_by_name("Colorado")

    assert_equal EconomicProfile, object.class
  end

  def test_find_by_name_is_case_insensitive
    assert_equal "Colorado", @epr.find_by_name("ColORADo").name
  end

end
