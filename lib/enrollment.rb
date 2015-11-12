
class Enrollment

  def initialize(data)
    @data = data
  end

  def kindergarten_participation_by_year

  end

  def kindergarten_participation_in_year(year)

  end

  def truncate(number)
    (number.to_f * 1000).to_i / 1000.0
  end

end

e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
