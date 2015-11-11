
class District
  attr_reader :name

  def initialize(name)
    @name = name.upcase
  end
end

# d = District.new({:name => "ACADEMY 20"})
