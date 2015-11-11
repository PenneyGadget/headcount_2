require 'minitest/autorun'
require 'minitest/emoji'
require './lib/district_repository'

class DistrictRepositoryTest < Minitest::Test

  def test_district_repository_class_exists
    assert DistrictRepository.new
  end

  def test_districts_hash_receives_all_districts_upon_initialize
    dr = DistrictRepository.new

    assert_equal 181, dr.districts.length
  end

  def test_find_by_name_is_case_insensitive
    dr = DistrictRepository.new

    assert_equal "COLORADO", dr.find_by_name("ColORadO").name
  end

  def test_find_by_name_returns_nil_with_an_invalid_name
    dr = DistrictRepository.new

    assert_equal nil, dr.find_by_name("Zombies")
  end

  def test_find_by_name_returns_nil_when_there_is_no_name
    dr = DistrictRepository.new

    assert_equal nil, dr.find_by_name("")
  end

  def test_find_by_name_returns_nil_when_a_number_is_passed_in
    dr = DistrictRepository.new

    assert_equal nil, dr.find_by_name(23)
  end

  def test_find_by_name_returns_a_district_object
    dr = DistrictRepository.new
    object = dr.find_by_name("Colorado")

    assert_equal District, object.class
  end

  def test_find_all_matching_returns_district_name_matches
    dr = DistrictRepository.new
    district = dr.find_all_matching("Colorado")

    assert_equal ["COLORADO", "COLORADO SPRINGS 11"], district
  end

  def test_find_all_matching_works_with_a_name_fragment
    dr = DistrictRepository.new
    districts = dr.find_all_matching("ca")

    assert_equal ["ACADEMY 20", "CALHAN RJ-1",
                  "CAMPO RE-6", "CANON CITY RE-1",
                  "KIT CARSON R-1", "PLATTE CANYON 1"], districts
  end

  def test_find_all_matching_returns_an_empty_array_with_an_invalid_entry
    dr = DistrictRepository.new
    district = dr.find_all_matching("poop")

    assert_equal [], district
  end

  def test_find_all_matching_returns_an_empty_array_with_blank_spaces
    dr = DistrictRepository.new
    district = dr.find_all_matching("  ")

    assert_equal [], district
  end

  def test_find_all_matching_returns_an_empty_array_with_an_invalid_number
    dr = DistrictRepository.new
    district = dr.find_all_matching(45)

    assert_equal [], district
  end

  def test_find_all_matching_works_with_a_valid_number
    dr = DistrictRepository.new
    district = dr.find_all_matching(20)

    assert_equal ["ACADEMY 20", "ARRIBA-FLAGLER C-20",
                 "ELBERT 200", "WELDON VALLEY RE-20(J)"], district
  end


end
