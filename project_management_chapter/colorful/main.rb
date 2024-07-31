p $LOADED_FEATURES.inspect.include?('colorize')
p $LOAD_PATH.inspect.include?('colorize')
require 'colorize'
$test = "test"
puts $test
puts 'Red goes faster!'.colorize(:red)

puts "I'm blue da ba dee da ba di!".colorize(:blue)

puts "It ain't easy bein' green...".colorize(:green)

p $LOADED_FEATURES.inspect.include?('colorize')

p $LOAD_PATH
