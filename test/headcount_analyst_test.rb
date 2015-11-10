require 'minitest/autorun'
require 'minitest/emoji'
require './lib/headcount_analyst'

class HeadcountAnalystTest < Minitest::Test

  def test_headcount_class_exists
    assert HeadcountAnalyst.new
  end

end
