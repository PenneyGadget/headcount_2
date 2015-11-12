
class Enrollment

  def initialize(data)
    @data = data
  end

  def kindergarten_participation_by_year
    puts @data
  end

  def kindergarten_participation_in_year(year)

  end

  def truncate(number)
    (number.to_f * 1000).to_i / 1000.0
  end

end
