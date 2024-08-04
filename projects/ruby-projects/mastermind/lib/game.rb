require 'debug'
require_relative 'board'
require_relative 'human_code_maker'
require_relative 'computer_code_maker'
require_relative 'human_code_breaker'
require_relative 'computer_code_breaker'
require_relative 'shared_constants'
require_relative 'utility_methods'

# class representing a game of Mastermind consisting of a board, and two players, 1 the makes, 6 the breaker.
class Game
  include SharedConstants
  include UtilityMethods

  def initialize
    @board = Board.new
    @code_breaker = nil
    @code_maker = nil
  end

  def setup_game
    case extract_player_role_from_input
    when 0
      self.code_breaker = HumanCodeBreaker.new
      self.code_maker = ComputerCodeMaker.new
    when 1
      self.code_breaker = ComputerCodeBreaker.new
      self.code_maker = HumanCodeMaker.new
      debugger
    end

    code = code_maker.generate_code
    board.setup_code(code)
  end

  def extract_player_role_from_input
    puts 'Do you want to play as the person breaking the code or making the code? write a 0 or 1, respectively'

    loop do
      choice = convert_to_i(gets.chomp)
      return choice if [0, 1].include?(choice)

      puts 'Please provide a 0 or 1.'
    end
  end

  def play_game # rubocop:disable Metrics/MethodLength
    NUMBER_OF_GUESSES.times do |guess_number| # guess number = numbe of guess.
      guess = process_guess(guess_number)
      p board.code

      winner_present = winner_present?(guess)
      board.display(winner_present)

      if winner_present
        winner = winner_in_hash?(guess).key(true)
        display_winner_message(winner)
        break
      end

      code_maker.provide_feedback(guess, board.code)
      puts
    end
  end

  def process_guess(guess_number) # rubocop:disable Metrics/MethodLength
    debugger if DEBUG
    guess = code_breaker.generate_guess(code.get_correct_positions_count)
    p guess if DEBUG
    guess = convert_code_to_colors(guess)
    board.update_data(
      guess_number,
      guess,
      code_maker.get_correct_positions_count(guess, board.code),
      code_maker.get_correct_colors_count(guess, board.code)
    )
    guess
  end

  def winner_in_hash?(guess)
    return { code_breaker => true, code_maker => false } if code_guessed?(guess)

    return { code_breaker => false, code_maker => true } if board.no_guess_left?

    { code_breaker => false, code_maker => false }
  end

  def winner_present?(guess)
    winner_in_hash?(guess).values.include? true
  end

  def display_winner_message(winner_instance) # TODO: display winner message based on computer or 'you' messgae.
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
