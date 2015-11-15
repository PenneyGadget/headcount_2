require 'minitest/autorun'
require 'minitest/emoji'
require './lib/district_repository'
require './lib/formatter'

class FormatterTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
    @formatter = Formatter.new(@dr)
    @dr.load_data({ :enrollment =>
                    { :kindergarten =>           "./data/Kindergartners in full-day program.csv",
                      :high_school_graduation => "./data/High school graduation rates.csv"
                    }
                  })
  end

  def test_call_formatter_formats_data_correctly
    data = {"BYERS 32J"=> [{:location=>"BYERS 32J", :timeframe=>"2007", :dataformat=>"Percent", :data=>"1"},
                           {:location=>"BYERS 32J", :timeframe=>"2006", :dataformat=>"Percent", :data=>"1"},
                           {:location=>"BYERS 32J", :timeframe=>"2005", :dataformat=>"Percent",:data=>"1"}]}

    expected = [{:name=>"BYERS 32J", :kindergarten_participation=>{"2007"=>"1", "2006"=>"1", "2005"=>"1"}}]

    assert_equal expected, @formatter.call_formatter(:kindergarten, data)
  end

  def test_package_stores_all_unique_districts
    assert_equal 179, @dr.enrollment_repo.enrollments.length
  end

  def test_that_extract_years_method_extracts_raw_data
    extracted_years = @formatter.extract_years_from_district_rows([{:location   => "Colorado",
                                                                    :timeframe  => "2007",
                                                                    :dataformat => "Percent",
                                                                    :data       => "0.39465"}])

    assert_equal({"2007"=>"0.39465"}, extracted_years)
  end

  def test_kindergarten_formatter
    parsed_data = {"ADAMS-ARAPAHOE 28J"=>[{:location=>"ADAMS-ARAPAHOE 28J", :timeframe=>"2007", :dataformat=>"Percent", :data=>"0.47359"},
                                          {:location=>"ADAMS-ARAPAHOE 28J", :timeframe=>"2006", :dataformat=>"Percent", :data=>"0.37013"},
                                          {:location=>"ADAMS-ARAPAHOE 28J", :timeframe=>"2005", :dataformat=>"Percent", :data=>"0.20176"}]}

    expected = [{:name=>"ADAMS-ARAPAHOE 28J", :kindergarten_participation=>{"2007"=>"0.47359", "2006"=>"0.37013", "2005"=>"0.20176"}}]

    assert_equal expected, @formatter.kindergarten_formatter(parsed_data)
  end

  def test_high_school_graduation_formatter
    parsed_data = {"ACADEMY 20"=>[{:location=>"ACADEMY 20", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.895"},
                                  {:location=>"ACADEMY 20", :timeframe=>"2012", :dataformat=>"Percent", :data=>"0.88983"},
                                  {:location=>"ACADEMY 20", :timeframe=>"2013", :dataformat=>"Percent", :data=>"0.91373"}]}

    expected = [{:name=>"ACADEMY 20", :high_school_graduation=>{"2011"=>"0.895", "2012"=>"0.88983", "2013"=>"0.91373"}}]

    assert_equal expected, @formatter.high_school_graduation_formatter(parsed_data)
  end

end
