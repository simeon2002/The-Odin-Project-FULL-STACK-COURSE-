require_relative 'save_utils'
module ScreenMessageUtility # rubocop:disable Style/Documentation
  extend SaveUtils
  def prompt_player_move
    puts 'Provide a character guess or write \'save\' to store the game and continue next time.'.colorize(mode: :bold)
  end

  def display_word_guess
    puts "The current word you have is: #{word_guessed.join(' ')}"
  end

  def display_guess_counts
    puts "Currently, you have #{guess_count} guesses left."
    puts "You have #{correct_guess_count} correct guesses and #{wrong_guess_count} wrong guesses"
  end

  def display_player_won
    puts 'You won, congratulations!'
  end

  def display_player_lost
    puts 'You lost, better next time!'
  end

  def display_wrong_guess(char_guess)
    puts "Wrong guess, #{char_guess} isn't present in the word "
      .colorize(color: :red)
  end

  def display_recurring_char
    puts 'Unfortunately you have already tried this characters. Be more careful next time.. you just lost a guess!\n'.colorize(color: :red) # rubocop:disable Layout/LineLength
  end

  def self.display_files
    unless Dir.exist?('saved_games')
      puts "you haven't played before, a new game will be started for you."
      return nil
    end

    saved_files = fetch_saved_files
    saved_files.each_with_index { |el, i| puts "input #{i} for #{el}" }
  end

  def welcome_message
    puts 'Welcome to the Hangman game. We are glad that you are joining us for a game.'
    puts 'NOTE: if more than one character is given, only the first character will be used for your guess!'
    puts
  end

  def self.display_loading_game
    puts 'Loading game...'
    sleep 1
    puts "\nWelcome back!"
  end
end
