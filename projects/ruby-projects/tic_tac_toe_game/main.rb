require_relative 'lib/player'
require_relative 'lib/board'
require_relative 'lib/game'
require 'debug'

# setup game.

board_methods = Board.instance_methods(false)
Board.private_instance_methods(false).each { |method| board_methods << method }
game_methods = Game.instance_methods(false)
Game.private_instance_methods(false).each { |method| game_methods << method }
player_methods = Player.instance_methods(false)
Player.private_instance_methods(false).each { |method| player_methods << method }
p "Board methods: #{board_methods}"
p "Game methods: #{game_methods}"
p "Player methods: #{player_methods}"

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
