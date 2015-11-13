
class District
  attr_reader :name, :enrollment

  def initialize(name)
    @name = name.upcase
  end

  def set_enrollment(enrollment)
    @enrollment = enrollment
  end

end
