require_relative 'lib/player'
require_relative 'lib/board'
require_relative 'lib/game'
require 'debug'

# setup game.
game = Game.new
game.setup_game
game.play_game
loop do
  puts
  puts 'Want to play another game? (answer with a yes or no)'
  unless gets.chomp == 'yes'
    puts 'well, thanks for playing the game!'
    break
  end
  puts
  game.reset
  game.play_game
end
