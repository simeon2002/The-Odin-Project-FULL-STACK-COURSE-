require 'csv'
require 'debug'
require 'google/apis/civicinfo_v2'
require 'erb'

DEBUG = false

# CODING EXAMPLE

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def parse_phone_number(row)
  row[:homephone].delete('^0-9')
end

def process_phone_number(phone_number)
  if phone_number.length == 10
    phone_number
  elsif phone_number.length == 11
    if phone_number[0] == '1' then phone_number[1..11]
    else
      '0' * 10
    end
  elsif phone_number.length > 11 || phone_number.length < 10
    '0' * 10
  end
end

def increment_count_grouped_by(group, count)
  # debugger
  count[group] += 1
end

def parse_registration_date(row)
  registration_date = row[:regdate]
  Time.strptime(registration_date, '%m/%d/%y %H:%M')
end

def sort_by_largest_count(count)
  count.sort_by do |_k, v|
    -v
  end.to_h
end

def get_top5_count(count)
  count_sorted = sort_by_largest_count(count)
  count_sorted.filter { |k, _| count_sorted.keys[0...5].include?(k) }.keys
end

# MAIN
#-------
start_time = Time.now
p start_time
puts 'EventManager initialized.'

contents = CSV.open(
  'attendees_large.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

hours_count = Hash.new(0)
weekday_count = Hash.new(0)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  phone_number = process_phone_number(parse_phone_number(row))

  reg_date = parse_registration_date(row)
  hour = reg_date.hour
  weekday = reg_date.strftime('%A')
  increment_count_grouped_by(hour, hours_count)
  increment_count_grouped_by(weekday, weekday_count)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)

  (p "#{phone_number} --- #{before}" unless before == phone_number) if DEBUG
end

# p "The best hour to push more adds is around "hours_count.
# hours_count_sorted = sort_by_largest_count(hours_count)

hours_count_top5 = get_top5_count(hours_count)
weekday_highest_count = weekday_count.max[0]

puts "We can see that the top 5 hours in which registrations were the most are: #{hours_count_top5.reverse.join('h, ')}h." # rubocop:disable Layout/LineLength
puts "We can see that the weekday with the highest number of registrations is a #{weekday_highest_count}."

p finish_time = Time.now
p "The code took #{finish_time - start_time} to execute"

p File.open('event_attendees.csv')
