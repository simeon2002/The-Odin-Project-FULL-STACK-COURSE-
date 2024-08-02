require 'debug'
require_relative 'board'
require_relative 'code_breaker'
require_relative 'code_maker'
require_relative 'shared_constants'
require_relative 'utility_methods'

# class representing a game of Mastermind consisting of a board, and two players, 1 the makes, 6 the breaker.
class Game
  include SharedConstants
  include UtilityMethods

  def initialize
    @board = Board.new
    @code_breaker = CodeBreaker.new
    @code_maker = CodeMaker.new
  end

  def setup_game
    code = code_maker.generate_code
    board.setup_code(code)
  end

  def play_game
    NUMBER_OF_GUESSES.times do |guess_number| # guess number = numbe of guess.
      guess = process_guess(guess_number)
      p board.code

      winner_present = evaluate_for_winner(guess)
      board.display(winner_present) # TODO:

      break if winner_present

      code_maker.provide_feedback(guess, board.code) # TODO: make provide_feedback
    end
  end

  def process_guess(guess_number)
    guess = code_breaker.get_guess
    guess = convert_guess_to_colors(guess)
    board.update_data(guess_number, guess)
    guess
  end

  def convert_guess_to_colors(guess)
    guess.map do |el|
      convert_color_index_to_color(el)
    end
  end

  def evaluate_for_winner(guess)
    if code_guessed?(guess)
      display_winner_message(code_breaker)
      return true
    end

    if board.no_guess_left?
      display_winner_message(code_maker)
      return true
    end

    false
  end

  def display_winner_message(winner_instance)
    puts
    if winner_instance.is_a?(CodeBreaker) then puts 'code breaker won.'
    elsif winner_instance.is_a?(CodeMaker) then puts 'code maker won.'
    end
  end

  def code_guessed?(guess)
    index = 0
    guess.all? do |el|
      test = el.include?(board.code[index])
      index += 1
      test
    end
  end

  private

  attr_accessor :board, :code_breaker, :code_maker
end
