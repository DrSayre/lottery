module States
  module Kentucky
    # Kentucky Pick 3
    class Three < PickThree
      scope :drawings, lambda {
        State.find_by(name: 'Kentucky').pick_threes
      }
      scope :drawings_three_months, lambda {
        State.find_by(name: 'Kentucky').pick_threes.where(
          drawing_date: 3.months.ago..Date.tomorrow
        )
      }
      scope :midday_drawings, lambda {
        drawings.where(
          drawing_time_id: DrawingTime.find_by(name: 'Midday').id
        )
      }
      scope :midday_drawings_three_months, lambda {
        drawings.where(
          drawing_time_id: DrawingTime.find_by(name: 'Midday').id,
          drawing_date: 3.months.ago..Date.tomorrow
        )
      }
      scope :evening_drawings, lambda {
        drawings.where(
          drawing_time_id: DrawingTime.find_by(name: 'Evening').id
        )
      }
      scope :evening_drawings_three_months, lambda {
        drawings.where(
          drawing_time_id: DrawingTime.find_by(name: 'Evening').id,
          drawing_date: 3.months.ago..Date.tomorrow
        )
      }

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
    end
  end
end
