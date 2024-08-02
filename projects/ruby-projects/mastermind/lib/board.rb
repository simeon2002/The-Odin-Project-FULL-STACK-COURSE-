require_relative 'shared_constants'
require_relative 'utility_methods'

# Board is the board on which the game is played container the secret code as well as all of the guesses.
class Board
  include SharedConstants
  include UtilityMethods

  attr_accessor :code, :guesses, :board

  def initialize
    @code = []
    # @guesses = Array.new(NUMBER_OF_GUESSES) { |_| Array.new(CODE_LENGTH, 'X') }
    @guesses = []
    @board = []
  end

  def display(winner_present)
    2.times { |_| puts }
    puts 'BOARD'.colorize(mode: :bold)
    puts '_____'
    board.each_with_index do |guess, index|
      if index.zero? && !winner_present
        print 'code: '.colorize(mode: :bold)
        CODE_LENGTH.times { |_| print 'X'.colorize(mode: :bold) }
        puts
        next
      end

      guess_matched_code = true if guess.eql?(code)

      guess.each do |color|
        if guess_matched_code
          print "#{color.colorize(background: :red)} "
          next
        end
        print "#{color.colorize(color: color.to_sym)
               } "
      end
      puts
    end

    2.times { |_| puts }
  end

  def setup_code(code)
    self.code = code
    board.push(code)
  end

  def update_data(index, guess)
    add_guess(index, guess)
    update_board(index + 1, guess)
  end

  def add_guess(index, guess)
    guesses[index] = guess
  end

  def update_board(index, guess)
    board[index] = guess
  end

  def no_guess_left?
    guesses.length == NUMBER_OF_GUESSES
  end
end
