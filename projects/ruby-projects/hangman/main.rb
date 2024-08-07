require_relative 'lib/game'

# MAIN
#------
load_game = Game.load_game?
game = load_game == true ? Game.load_game : Game.new
game.setup_game unless load_game == true

loop do
  game.play_game

  unless Game.play_again?
    puts 'Okay, thank you for playing! Until next time.'
    break
  end

  puts
  game.reset_game
end
