# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
State.create(name: 'Kentucky')
DrawingTime.create(name: 'Midday')
DrawingTime.create(name: 'Evening')
def save_three_numbers(results, draw)
  time = DrawingTime.find_by name: draw
  state = State.find_or_create_by name: 'Kentucky'
  results.each do |result|
    results_row = result.css('td')
    numbers = results_row[2].css('span').text.strip
    winning_numbers = numbers.scan(/\d/)
    drawing_date = Date.strptime(results_row[1].text,"%m/%d/%Y")
    PickThree.create(drawing_date: drawing_date, first_number: winning_numbers[0], second_number: winning_numbers[1], third_number: winning_numbers[2], drawing_time_id: time.id, state_id: state.id) if numbers.match /^\d/
  end
end

def save_four_numbers(results, draw)
  time = DrawingTime.find_by name: draw
  state = State.find_or_create_by name: 'Kentucky'
  results.each do |result|
    results_row = result.css('td')
    numbers = results_row[2].css('span').text.strip
    winning_numbers = numbers.scan(/\d/)
    drawing_date = Date.strptime(results_row[1].text,"%m/%d/%Y")
    PickFour.create(drawing_date: drawing_date, first_number: winning_numbers[0], second_number: winning_numbers[1], third_number: winning_numbers[2], fourth_number: winning_numbers[3], drawing_time_id: time.id, state_id: state.id) if numbers.match /^\d/
  end
end

agent = Mechanize.new

html = agent.get('http://www.kylottery.com/apps/draw_games/pick3/pick3_pastwinning.html').body

midday_results = Nokogiri::HTML(html).css('table table')[0].css('tbody').css('tr')
night_results = Nokogiri::HTML(html).css('table table')[1].css('tbody').css('tr')

save_three_numbers(midday_results, 'Midday')

save_three_numbers(night_results, 'Evening')

html = agent.get('http://www.kylottery.com/apps/draw_games/pick4/pick4_pastwinning.html').body

midday_results = Nokogiri::HTML(html).css('table table')[0].css('tbody').css('tr')
night_results = Nokogiri::HTML(html).css('table table')[1].css('tbody').css('tr')

save_four_numbers(midday_results, 'Midday')

save_four_numbers(night_results, 'Evening')
