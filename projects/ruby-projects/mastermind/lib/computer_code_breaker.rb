require_relative 'code_breaker'
require_relative 'shared_constants'
require_relative 'utility_methods'

class ComputerCodeBreaker < CodeBreaker # rubocop:disable Style/Documentation
  include SharedConstants
  include UtilityMethods

  def initialize
    super
    self.correct_colors_guesses = {}
  end

  def generate_guess(code)
    sleep 2
    code = convert_colors_to_code(code)

    guess = random_guess

    parse_correct_positions(guess, code)

    replace_guess_colors_to_correct(guess)

    guess
  end

  def random_guess
    (0...COLORS.length).to_a.shuffle
  end

  private

  def parse_correct_positions(guess, code)
    guess.each_with_index do |el, i|
      correct_colors_guesses[i] = el if guess[i] == code[i]
    end
  end

  def replace_guess_colors_to_correct(guess)
    correct_colors_guesses.each do |k, v|
      guess[k] = v
    end
  end

  attr_accessor :correct_colors_guesses
end
