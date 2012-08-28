require 'blacklead'

cl = Blacklead::Client.new('ew', 'k@b00m01')
test_event = 'FTE_LEVEL_UP_27'
test_minutes_from = 5
url = cl.create_url(test_event,test_minutes_from)

response = cl.get_response(url)
min_value = cl.get_min_value(response)
max_value = cl.get_max_value(response)
avg_value = cl.get_avg_value(response)
sum_values = cl.get_sum_values(response)
values = cl.get_values(response)
event = cl.get_event(response)
check_values = cl.check_values(response)

puts "----------------------------------------------------------------------------"
puts "test_event: #{test_event}"
puts "test_minutes_from: #{test_minutes_from}"
puts "----------------------------------------------------------------------------"
puts "response: #{response}"
puts "event: #{event}"
puts "values: #{values}"
puts "min_value is: #{min_value}"
puts "max_value is: #{max_value}"
puts "sum_values is: #{sum_values}"
puts "check_values is: #{check_values}"
puts "avg_value is: #{avg_value}"


