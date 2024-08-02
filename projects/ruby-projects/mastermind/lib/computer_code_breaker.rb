require_relative 'code_breaker'
require_relative 'shared_constants'

class ComputerCodeBreaker < CodeBreaker # rubocop:disable Style/Documentation
  include SharedConstants
  def generate_guess
    sleep 1
    (0...COLORS.length).to_a.shuffle
  end
end
