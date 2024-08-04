require_relative 'code_breaker'
require_relative 'shared_constants'

class HumanCodeBreaker < CodeBreaker # rubocop:disable Style/Documentation
  include SharedConstants

  def generate_guess(_code)
    guess = []
    loop do
      display_guess_input_description
      guess = extract_code_from_input
      break if guess
    end
    guess
  end

  def display_guess_input_description
    puts "Provide a guess for the secret code represented by a #{CODE_LENGTH} comma-separated values of integers from 1 through #{COLORS.length} representing one of the possible colors: #{COLORS.join(', ')}.".colorize(mode: :bold) # rubocop:disable Layout/LineLength
  end
end
