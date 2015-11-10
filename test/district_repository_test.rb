require 'minitest/autorun'
require 'minitest/emoji'
require './lib/district_repository'

class DistrictRepositoryTest < Minitest::Test

  def test_district_repository_class_exists
    assert DistrictRepository.new
  end

  def test_find_by_name_is_case_insensitive
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})

    assert_equal "COLORADO", dr.find_by_name("ColORadO")
  end

  def test_find_by_name_returns_nil_with_an_invalid_or_missing_district_name
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})

    assert_equal nil, dr.find_by_name("Zombies")
  end

  def test_find_by_name_returns_a_single_instance_of_district

  end

  def test_find_all_matching_returns_one_district_name_match
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})
    district = dr.find_all_matching("Colorado")

    assert_equal ["COLORADO"], district
  end

  def test_find_all_matching_works_with_a_name_fragment
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})
    districts = dr.find_all_matching("ca")

    assert_equal ["ACADEMY 20", "CAMPO RE-6", "CANON CITY RE-1"], districts
  end

  def test_find_all_matching_returns_an_empty_array_with_no_matches
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})
    district = dr.find_all_matching("poop")

    assert_equal [], district
  end

  def test_data_hash_is_empty_initially
    dr = DistrictRepository.new

    assert_equal 0, dr.data.length
  end

  def test_load_data_adds_csv_table_to_data_hash
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})

    assert_equal 1, dr.data.length
  end

  def test_load_data_creates_proper_key_in_data_hash
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./test/fixtures/Kindergartners in full-day program fixture.csv"}})

    assert_equal [:kindergarten], dr.data.keys
  end

end
