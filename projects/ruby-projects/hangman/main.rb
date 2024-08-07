require_relative 'lib/game'

def play_again?
  loop do
    puts 'Do you want to play the game again? [y]es or [n]o'
    answer = gets.chomp.downcase
    if %w[y yes].include?(answer)
      return true
    elsif %w[n no].include?(answer)
      return false
    end

    puts 'please provide a yes or no answer.'
  end
end

game = Game.new

loop do
  game.play_game

  unless play_again?
    puts 'Okay, thank you for playin! Until next time.'
    break
  end
end
