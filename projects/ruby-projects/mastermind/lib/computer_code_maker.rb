require_relative 'shared_constants'
require_relative 'utility_methods'

class ComputerCodeMaker < CodeMaker # rubocop:disable Style/Documentation
  include SharedConstants
  include UtilityMethods

  def generate_code
    code = []
    CODE_LENGTH.times do |i|
      code[i] = COLORS[rand(0...(COLORS.length))]
    end
    p code if DEBUG
    code
  end
end
