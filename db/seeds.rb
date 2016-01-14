# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def print_numbers(results)
  results.each do |result|
    foo = result.css('td')
    numbers = foo[2].css('span').text.strip
    winning_numbers = numbers.scan(/\d/)
    PickThree.create(drawing_date: foo[1].text, first_number: winning_numbers[0], second_number: winning_numbers[1], third_number: winning_numbers[2]) if numbers.match /^\d/
    # print "\n==========\nDate: #{foo[1].text}\nNumbers: #{winning_numbers[0]} #{winning_numbers[1]} #{winning_numbers[2]}\n==========\n" if numbers.match /^\d/
  end
end

agent = Mechanize.new

html = agent.get('http://www.kylottery.com/apps/draw_games/pick3/pick3_pastwinning.html').body

midday_results = Nokogiri::HTML(html).css('table table')[0].css('tbody').css('tr')
night_results = Nokogiri::HTML(html).css('table table')[1].css('tbody').css('tr')

print_numbers(midday_results)

print_numbers(night_results)