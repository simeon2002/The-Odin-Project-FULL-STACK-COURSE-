class WordMaker # rubocop:disable Style/Documentation
  def generate_word
    words = parse_dictionary_file
    words.sample
  end

  def parse_dictionary_file
    file = File.new('google_10000_english_no_swears.txt')
    if File.exist?(file)
      file.readlines(chomp: true).filter { |el| el.length >= 5 && el.length <= 12 }
    else
      puts 'File doesn\'t exist!'
    end
  end

  def display_board
    display_word_guess
    display_guess_counts
    puts
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
end
