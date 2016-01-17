# Pick 4 Model
class PickFour < ApplicationRecord
  has_one :state
  has_one :drawing_time

  def self.group_numbers(group, drawing_time, drawing_time_three_months)
    numbers = number_candidates(drawings.group(group).count)
    numbers += number_candidates(drawings_three_months.group(group).count)
    numbers += number_candidates(drawing_time.group(group).count)
    numbers += number_candidates(drawing_time_three_months.group(group).count)
    numbers.uniq
  end

  def self.number_candidates(breakdown)
    candidates = []
    mean = breakdown.mean
    standard_deviation = breakdown.standard_deviation
    target_value = mean - standard_deviation
    breakdown.each do |key, value|
      candidates << key if value < target_value
    end
    candidates
  end
end
