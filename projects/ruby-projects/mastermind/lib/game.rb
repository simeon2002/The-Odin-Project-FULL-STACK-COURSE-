require_relative 'board'
require_relative 'code_breaker'
require_relative 'code_maker'
require_relative 'shared_constants'

# class representing a game of Mastermind consisting of a board, and two players, 1 the makes, 1 the breaker.
class Game
  include SharedConstants

  def initialize
    @board = Board.new
    @code_breaker = CodeBreaker.new
    @code_maker = CodeMaker.new
  end

  def setup_game
    code = code_maker.generate_code
    p code
  end

  private

  attr_accessor :board, :code_breaker, :code_maker
end
