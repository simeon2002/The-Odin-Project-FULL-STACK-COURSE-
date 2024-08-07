require_relative 'word_guesser'
require_relative 'word_maker'
require_relative 'screen_message_utility'
require_relative 'save_utils'
require_relative 'game_utils'
require 'debug'
require 'colorize'
require 'yaml'

class Game # rubocop:disable Style/Documentation
  include ScreenMessageUtility
  extend SaveUtils
  include GameUtils
  DEBUG = true

  @@game_file_number = 0 # rubocop:disable Style/ClassVars

  def initialize
    @chars_tried = []
    @word_generated = []
    @word_guessed = []
    @word_maker = WordMaker.new
    @word_guesser = WordGuesser.new
    @guess_count = NUMBER_OF_GUESSES
    @correct_guess_count = 0
  end

  def self.play_again?
    loop do
      puts 'Do you want to play another game? [y]es or [n]o'
      answer = gets.chomp.downcase
      if %w[y yes].include?(answer)
        return true
      elsif %w[n no].include?(answer)
        return false
      end

      puts 'please provide a yes or no answer.'
    end
  end

  def self.load_game?
    puts 'Do you want to load a previously saved game? [y]es or [n]o'
    answer = gets.chomp.downcase

    return true if %w[y yes].include?(answer)

    false
  end

  def self.load_game
    file = parse_file_from_yaml
    game = Game.from_yaml(file.read)
    file.close

    ScreenMessageUtility.display_loading_game

    game
  end

  def play_game # rubocop:disable Metrics/MethodLength
    loop do
      display_board

      self.guess_count -= 1
      guess = retrieve_player_guess

      if guess == 'save'
        save_game
        break
      end

      play_round(guess)

      chars_tried << guess unless chars_tried.include?(guess)

      break if end_of_game?
    end
  end

  def reset_game
    self.chars_tried = []
    self.word_generated = []
    self.word_guessed = []
    self.guess_count = NUMBER_OF_GUESSES
    self.correct_guess_count = 0
    setup_game
  end

  def save_game
    debugger
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games') # rubocop:disable Lint/NonAtomicFileOperation
    game_file = File.new("saved_games/game_file#{@@game_file_number}_#{Time.now.strftime('%c')}.yaml", 'w')
    game_file << to_yaml
    game_file.close
    @@game_file_number += 1 # rubocop:disable Style/ClassVars
  end

  def setup_game
    self.word_generated = word_maker.generate_word.chars
    self.word_guessed = Array.new(word_generated.length) { |_| '_' }
    welcome_message
  end

  def to_yaml
    {
      chars_tried: chars_tried,
      word_generated: word_generated,
      word_guessed: word_guessed,
      guess_count: guess_count,
      correct_guess_count: correct_guess_count
    }.to_yaml
  end

  def self.from_yaml(string)
    data = YAML.load(string) # rubocop:disable Security/YAMLLoad
    game = new

    # Directly set instance variables, bypassing private accessors
    game.instance_variable_set(:@chars_tried, data[:chars_tried])
    game.instance_variable_set(:@word_generated, data[:word_generated])
    game.instance_variable_set(:@word_guessed, data[:word_guessed])
    game.instance_variable_set(:@guess_count, data[:guess_count])
    game.instance_variable_set(:@correct_guess_count, data[:correct_guess_count])

    game
  end

  def display_board
    display_word_guess
    display_guess_counts
    puts
  end

  private

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

  attr_accessor :chars_tried, :word_generated, :word_guessed, :word_maker, :word_guesser, :guess_count,
                :correct_guess_count
end
