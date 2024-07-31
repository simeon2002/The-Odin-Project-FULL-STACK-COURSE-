require_relative 'lib/player'
require_relative 'lib/board'
require_relative 'lib/game'
require 'debug'

# setup game.
game = Game.new
game.setup_game
loop do
  game.play_game
  puts
  puts 'Want to play another game? (answer with a yes or no)'
  break unless gets.chomp == 'yes'

  game.reset
  game.play_game
end
