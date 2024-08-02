require_relative 'shared_constants'
require_relative 'utility_methods'
require_relative 'code_maker'

class HumanCodeMaker < CodeMaker # rubocop:disable Style/Documentation
  include SharedConstants
  include UtilityMethods

  def generate_code
    puts "provide a secret code consisting of #{CODE_LENGTH} comma separated numbers ranging from 1 through 4 representing one of the possible colors: #{COLORS.join(', ')}.".colorize(mode: :bold) # rubocop:disable Layout/LineLength

    code = extract_code_from_input
    convert_code_to_colors(code)
  end
end
