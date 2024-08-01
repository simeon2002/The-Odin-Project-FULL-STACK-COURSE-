require_relative 'shared_constants'
# Board is the board on which the game is played container the secret code as well as all of the guesses.
class Board
  include SharedConstants

  attr_accessor :code, :guesses, :board

  def initialize
    @code = []
    @guesses = Array.new(NUMBER_OF_GUESSES) { |_| Array.new(CODE_LENGTH) }
    @board = guesses.unshift(code)
  end

  def display; end

  def add_guess(guess); end

  def all_guesses_used?
    return true if guesses.length == NUMBER_OF_GUESSES

    false
  end
end
