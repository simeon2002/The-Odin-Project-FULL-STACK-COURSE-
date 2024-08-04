require_relative 'code_breaker'
require_relative 'shared_constants'
require_relative 'utility_methods'

class ComputerCodeBreaker < CodeBreaker # rubocop:disable Style/Documentation
  include SharedConstants
  include UtilityMethods

  def initialize
    super
    self.correct_pos_present = false
    self.previous_guess = nil
  end

  def generate_guess(correct_pos_count)
    sleep 2
    self.correct_pos_present = true if correct_pos_count.zero?

    # either guess has no correct color present
    if !correct_pos_present
      guess = random_guess
      previous_guess = guess # rubocop:disable Lint/UselessAssignment
      guess
    # or guess has correct color present. We have to find which.
    else

    end

    # TODO: make correct_pos_present whenever required.
  end

  # useful: COLORS.repeated_permutation(CODE_LENGTH).to_a --> gives all possible permutations of length specified code_length

  def random_guess
    (0...COLORS.length).to_a.shuffle
  end

  private

  attr_accessor :correct_pos_present, :previous_guess
end
