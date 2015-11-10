require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'

class DistrictRepositoryTest < Minitest::Test

  def test_district_repository_class_exists
    assert DistrictRepository.new
  end

  def test_find_by_name_returns_a_case_insensitive_district_instance
    skip
  end

  def test_find_by_name_returns_nil_with_an_invalid_or_missing_district_name
    skip
  end

  def test_find_all_matching_returns_one_or_more_district_name_matches
    skip
  end

  def test_find_all_matching_works_with_a_name_fragment
    skip
  end

  def test_find_all_matching_returns_an_empty_array_with_no_matches
    skip
  end

  def test_load_data_takes_the_proper_hash_arguments
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})

  end

end
