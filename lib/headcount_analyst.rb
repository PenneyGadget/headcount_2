require 'pry'
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
    trend = Hash.new
    d1_data = get_kp_data_with_year(@dr.find_by_name(dist1))
    d2_data = get_kp_data_with_year(@dr.find_by_name(dist2[:against]))
    d1_data.each { | k, v | trend[k] = truncate(d1_data[k] / d2_data[k]) }
    trend
  end

  def get_kp_data(dist)
    data_array = Array.new
    dist.enrollment.data[:kindergarten_participation].each do | k, v |
      data_array << v.to_f
    end
    data_array
  end

  def get_kp_data_with_year(dist)
    data_hash = Hash.new
    dist.enrollment.data[:kindergarten_participation].each do | k, v |
      data_hash[k] = v.to_f
    end
    data_hash
  end

  def kindergarten_participation_against_high_school_graduation(district)
    kp = kindergarten_participation_rate_variation(district, :against => "COLORADO")
    gr = high_school_graduation_rate_variation(district, :against => "COLORADO")
    truncate(kp/gr)
  end

  def high_school_graduation_rate_variation(dist1, dist2)
    d1_part = get_avg(get_hs_grad_data(@dr.find_by_name(dist1)))
    d2_part = get_avg(get_hs_grad_data(@dr.find_by_name(dist2[:against])))
    final = d1_part / d2_part
    truncate(final)
  end

  def get_hs_grad_data(dist)
    data_array = Array.new
    dist.enrollment.data[:high_school_graduation].each do | k, v |
      data_array << v.to_f
    end
    data_array
  end

  def kindergarten_participation_correlates_with_high_school_graduation(tag_and_location)
    if tag_and_location[:for] == 'STATEWIDE'
      districts = @dr.enrollment_repo.enrollments.map { | e | e }
      districts_with_correlation(districts) >= 0.7
    elsif tag_and_location.include?(:for)
      correlation = kindergarten_participation_against_high_school_graduation(tag_and_location[:for])
      correlation >= 0.6 && correlation <= 1.5
    elsif tag_and_location.include?(:across)
      districts = tag_and_location[:across].map { | n | @dr.enrollment_repo.find_by_name(n) }
      districts_with_correlation(districts) >= 0.7
    end
  end

  def districts_with_correlation(districts)
    names = Array.new
    correlated = Array.new
    districts.each { | dist | names << dist.name }
    names.each do | name |
      correlated << kindergarten_participation_correlates_with_high_school_graduation(:for => name)
    end
    correlated.count { | boolean | boolean == true } / correlated.length.to_f
  end

  def get_avg(data)
    data.reduce(:+) / data.length
  end

  def truncate(number)
    (number.to_f * 1000).to_i / 1000.0
  end

end
