require 'colorize'
require_relative 'shared_constants'
require_relative 'utility_methods'

class CodeBreaker # rubocop:disable Style/Documentation
  include SharedConstants
  include UtilityMethods

  def get_guess # rubocop:disable Naming/AccessorMethodName
    guess = []
    loop do
      display_guess_input_description
      guess = extract_guess_from_input
      break if guess
    end
    guess
  end

  def extract_guess_from_input
    guess = gets.split(/\s*,\s*|\s+/)
    # debugger if DEBUG
    unless only_permitted_integers_present?(guess) && guess_length_correct?(guess)
      puts "Please provide only integers corresponding to the correct color that are ranging from 1 to #{CODE_LENGTH}.."
        .colorize(
          color: :red, mode: :bold
        )
      return nil
    end
    guess.map { |el| convert_to_i(el) - 1 }
  end

  def guess_length_correct?(guess)
    guess.length == CODE_LENGTH
  end

  def display_guess_input_description
    puts "Provide a guess for the secret code represented by a #{CODE_LENGTH} comma-separated values of integers from 1 through #{COLORS.length} representing one of the possible colors: #{COLORS.join(', ')}.".colorize(mode: :bold) # rubocop:disable Layout/LineLength
  end
end
