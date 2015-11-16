require 'pry'

class StatewideTest

  attr_reader :data

  def initialize(data)
    @data = data
  end
  
  def name
    @data[:name]
  end

  def proficient_by_grade(grade)
    if grade_is_valid(grade)
      return query_hash_by_three(@data[:third_grade], :timeframe, [{:score => :data}]) if grade == 3
      return query_hash_by_three(@data[:eighth_grade], :timeframe, [{:score => :data}]) if grade == 8
    end
  end

  def grade_is_valid(grade)
    return @data.has_key?(:third_grade) if grade == 3
    return @data.has_key?(:eighth_grade) if grade == 8
    raise "UnknownDataError"
  end

  def proficient_by_race_or_ethnicity(race_or_ethnicity)
    if race_or_ethnicity_is_valid(race_or_ethnicity)
      math = query_hash_by_three_with_race_by_subject(race_or_ethnicity, :math, @data[:math], :timeframe, [{:score => :data}])
      reading = query_hash_by_three_with_race_by_subject(race_or_ethnicity, :reading, @data[:reading], :timeframe, [{:score => :data}])
      writing = query_hash_by_three_with_race_by_subject(race_or_ethnicity, :writing, @data[:writing], :timeframe, [{:score => :data}])
      math.merge(reading.merge(writing) { |k, v1, v2| v1.merge(v2) }) { |k, v1, v2| v1.merge(v2) }
    end
  end

  def race_or_ethnicity_is_valid(race_or_ethnicity)
    valid_races = [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    valid_races.include?(race_or_ethnicity.downcase) ? true : (raise "UnknownRaceError")
  end

  def query_hash_by_three(hash_array, group_by, columns)
    return_hash = {}
    hash_array.each do | hash_row |
      columns.each do | col |
        col.each do | key, value |
          return_hash = return_hash.merge({ hash_row[group_by].to_i => { hash_row[key].downcase.to_sym => truncate(hash_row[value]) }}) { |k, v1, v2| v1.merge(v2) }
        end
      end
    end
    return_hash
  end

  def query_hash_by_three_with_race_by_subject(race, subject, hash_array, group_by, columns)
    return_hash = {}
    hash_array.each do | hash_row |
      columns.each do | col |
        col.each do | key, value |
          if hash_row[:race_ethnicity].downcase == race.to_s
            return_hash = return_hash.merge({ hash_row[group_by].to_i => { subject => truncate(hash_row[value]) }}) { |k, v1, v2| v1.merge(v2) }
          end
        end
      end
    end
    return_hash
  end

  def truncate(number)
    (number.to_f * 1000).to_i / 1000.0
  end

end