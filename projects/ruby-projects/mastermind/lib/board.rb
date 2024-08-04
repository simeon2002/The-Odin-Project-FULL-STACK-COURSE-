require_relative 'shared_constants'
require_relative 'utility_methods'

# Board is the board on which the game is played container the secret code as well as all of the guesses.
class Board
  include SharedConstants
  include UtilityMethods

  attr_accessor :code, :guesses, :board, :guess_hints

  def initialize
    @code = []
    # @guesses = Array.new(NUMBER_OF_GUESSES) { |_| Array.new(CODE_LENGTH, 'X') }
    @guesses = []
    @board = []
    @guess_hints = []
  end

  def display(winner_present) # rubocop:disable Metrics/MethodLength
    puts "\nBOARD\n_____".colorize(mode: :bold)

    board.each_with_index do |guess, index|
      if index.zero?
        display_secret_code_message(winner_present)
        next
      else
        display_guess_in_color(guess)
      end
      display_hint(index)
      puts
    end
  end

  def display_guess_in_color(guess)
    guess_mached = guess_matched_code?(guess)
    guess.each do |color|
      if guess_mached
        print "#{color.colorize(background: :red)} "
        next
      end
      print "#{color.colorize(color: color.to_sym)} "
    end
  end

  def guess_matched_code?(guess)
    guess.eql?(code)
  end

  def display_secret_code_message(winner_present)
    print 'code: '.colorize(mode: :bold)
    if winner_present
      code.each { |color| print "#{color.colorize(background: :red)} " }
    else
      CODE_LENGTH.times { |_| print 'X'.colorize(mode: :bold) }
    end
    puts
  end

  def display_hint(index)
    print "|| #{guess_hints[index][0].to_s.colorize(color: :red)} - #{guess_hints[index][1].to_s.colorize(color: :white)} " # rubocop:disable Layout/LineLength.
  end

  def setup_code(code)
    self.code = code
    board.push(code)
  end

  def update_data(index, guess, correct_positions_count, correct_colors_count)
    add_guess(index, guess)
    update_board(index + 1, guess) # + 1 because first entry = code!
    add_guess_hint(index + 1, correct_positions_count, correct_colors_count)
  end

  def add_guess(index, guess)
    guesses[index] = guess
  end

  def add_guess_hint(index, correct_positions_count, correct_colors_count)
    guess_hints[index] = [correct_positions_count, correct_colors_count]
  end

  def update_board(index, guess)
    board[index] = guess
  end

  def no_guess_left?
    guesses.length == NUMBER_OF_GUESSES
  end
end
