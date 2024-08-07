require_relative 'word_guesser'
require_relative 'word_maker'
require 'debug'
require 'colorize'

class Game # rubocop:disable Style/Documentation
  NUMBER_OF_GUESSES = 16
  DEBUG = true

  def initialize
    @chars_tried = []
    @word_generated = []
    @word_guessed = []
    @word_maker = WordMaker.new
    @word_guesser = WordGuesser.new
    @guess_count = NUMBER_OF_GUESSES
    @correct_guess_count = 0
  end

  def play_game
    setup_game

    loop do
      self.guess_count -= 1
      debugger
      char_guess = retrieve_player_guess

      play_round(char_guess)

      chars_tried << char_guess unless chars_tried.include?(char_guess)

      display_board

      break if end_of_game?
    end
  end

  def reset_game
    self.chars_tried = []
    self.word_generated = []
    self.word_guessed = []
    self.guess_count = NUMBER_OF_GUESSES
    self.correct_guess_count = 0
  end

  def save_game; end

  private

  def setup_game
    self.word_generated = word_maker.generate_word.chars
    self.word_guessed = Array.new(word_generated.length) { |_| '_' }
  end

  def play_round(char_guess)
    if char_already_tried?(char_guess)
      display_recurring_char
    elsif char_present?(char_guess)
      add_char_to_guess(char_guess)
      self.correct_guess_count += 1
    else # when not tried already AND not present in word
      display_wrong_guess(char_guess)
    end
  end

  def add_char_to_guess(char_guess)
    char_indices = store_indices_in_word_of(char_guess)
    char_indices.each do |index|
      word_guessed[index] = char_guess
    end
  end

  def retrieve_player_guess
    prompt_player_move
    word_guesser.extract_guess_from_input
  end

  def store_indices_in_word_of(char)
    char_indices = []
    word_generated.each_index { |i| char_indices << i if word_generated[i] == char }
    char_indices
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

  def char_present?(char_guess)
    word_generated.include?(char_guess)
  end

  def char_already_tried?(char_guess)
    chars_tried.include?(char_guess)
  end

  def prompt_player_move
    puts 'Provide a guess of a character that might be present please. NOTE: if more than one character is given, only the first character will be used for your guess!'.colorize(mode: :bold) # rubocop:disable Layout/LineLength
  end

  def wrong_guess_count
    guesses_taken = NUMBER_OF_GUESSES - guess_count

    guesses_taken - correct_guess_count
  end

  def player_lost?
    # debugger
    guess_count.zero?
  end

  def player_won?
    word_generated == word_guessed
  end

  def end_of_game?
    if player_lost?
      display_player_lost
      true
    elsif player_won?
      display_player_won
      true
    else
      false
    end
  end

  attr_accessor :chars_tried, :word_generated, :word_guessed, :word_maker, :word_guesser, :guess_count,
                :correct_guess_count
end
