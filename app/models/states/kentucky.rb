module States
  # Kentucky Pick 3
  class Kentucky < PickThree
    scope :drawings, -> { State.find_by(name: 'Kentucky').pick_threes }
    scope :midday_drawings, -> { drawings.where(drawing_time_id: DrawingTime.find_by(name: 'Midday').id) }
    scope :evening_drawings, -> { drawings.where(drawing_time_id: DrawingTime.find_by(name: 'Evening').id) }

    def self.foo
      first_numbers = bar(drawings.group(:first_number).count)
      first_numbers = first_numbers + bar(drawings.where(drawing_date: 3.months.ago..Date.tomorrow).group(:first_number).count)
      first_numbers = first_numbers + bar(evening_drawings.group(:first_number).count)
      first_numbers = first_numbers + bar(evening_drawings.where(drawing_date: 3.months.ago..Date.tomorrow).group(:first_number).count)
      first_numbers = first_numbers.uniq

      second_numbers = bar(drawings.group(:second_number).count)
      second_numbers = second_numbers + bar(drawings.where(drawing_date: 3.months.ago..Date.tomorrow).group(:second_number).count)
      second_numbers = second_numbers + bar(evening_drawings.group(:second_number).count)
      second_numbers = second_numbers + bar(evening_drawings.where(drawing_date: 3.months.ago..Date.tomorrow).group(:second_number).count)
      second_numbers = second_numbers.uniq

      third_numbers = bar(drawings.group(:third_number).count)
      third_numbers = third_numbers + bar(drawings.where(drawing_date: 3.months.ago..Date.tomorrow).group(:third_number).count)
      third_numbers = third_numbers + bar(evening_drawings.group(:third_number).count)
      third_numbers = third_numbers + bar(evening_drawings.where(drawing_date: 3.months.ago..Date.tomorrow).group(:third_number).count)
      third_numbers = third_numbers.uniq

      [first_numbers, second_numbers, third_numbers]
    end

    def self.bar(breakdown)
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
end
