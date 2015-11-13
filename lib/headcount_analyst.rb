require_relative 'district_repository'

class HeadcountAnalyst

  def initialize(dr)
    @dr = dr
  end

  def kindergarten_participation_rate_variation(dist1, dist2)
    d1_part = get_avg(get_kp_data(@dr.find_by_name(dist1)))
    d2_part = get_avg(get_kp_data(@dr.find_by_name(dist2[:against])))
    final = d1_part / d2_part
    truncate(final)
  end

  def kindergarten_participation_rate_variation_trend(dist1, dist2)
    trend = {}
    d1_data = get_kp_data_with_year(@dr.find_by_name(dist1))
    d2_data = get_kp_data_with_year(@dr.find_by_name(dist2[:against]))
    d1_data.each { | k, v | trend[k] = truncate(d1_data[k] / d2_data[k]) }
    trend
  end

  def get_kp_data(dist)
    data = []
    dist.enrollment.data[:kindergarten_participation].each do | k, v |
      data << v.to_f
    end
    data
  end

  def get_kp_data_with_year(dist)
    data = {}
    dist.enrollment.data[:kindergarten_participation].each do | k, v |
      data[k] = v.to_f
    end
    data
  end

  def get_avg(data)
    data.reduce(:+) / data.length
  end

  def truncate(number)
    (number.to_f * 1000).to_i / 1000.0
  end

end
