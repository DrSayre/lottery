module States
  module PickThreeGames
    # Kentucky Pick 3
    class Kentucky < PickThree
      scope :drawings, -> { State.find_by(name: 'Kentucky').pick_threes }
      scope :drawings_three_months, -> { State.find_by(name: 'Kentucky').pick_threes.where(drawing_date: 3.months.ago..Date.tomorrow) }
      scope :midday_drawings, -> { drawings.where(drawing_time_id: DrawingTime.find_by(name: 'Midday').id) }
      scope :midday_drawings_three_months, -> { drawings.where(drawing_time_id: DrawingTime.find_by(name: 'Midday').id, drawing_date: 3.months.ago..Date.tomorrow) }
      scope :evening_drawings, -> { drawings.where(drawing_time_id: DrawingTime.find_by(name: 'Evening').id) }
      scope :evening_drawings_three_months, -> { drawings.where(drawing_time_id: DrawingTime.find_by(name: 'Evening').id, drawing_date: 3.months.ago..Date.tomorrow) }

      def self.evening_drawing_numbers
        [
          group_numbers(:first_number, evening_drawings, evening_drawings_three_months),
          group_numbers(:second_number, evening_drawings, evening_drawings_three_months),
          group_numbers(:third_number, evening_drawings, evening_drawings_three_months)
        ]
      end

      def self.midday_drawing_numbers
        [
          group_numbers(:first_number, midday_drawings, midday_drawings_three_months),
          group_numbers(:second_number, midday_drawings, midday_drawings_three_months),
          group_numbers(:third_number, midday_drawings, midday_drawings_three_months)
        ]
      end

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
  end
end
