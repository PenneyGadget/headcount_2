class District

  attr_reader :name, :enrollment, :statewide_test

  def initialize(name)
    @name = name[:name].upcase
  end

  def set_enrollment(enrollment)
    @enrollment = enrollment
  end

  def set_statewide_test(statewide_test)
    @statewide_test = statewide_test
  end

end
