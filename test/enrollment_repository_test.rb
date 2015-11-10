require 'minitest/autorun'
require 'minitest/emoji'
require './lib/enrollment_repository'

class EnrollmentRepositoryTest < Minitest::Test

  def test_enrollment_repository_class_exists
    assert EnrollmentRepository.new
  end

end
