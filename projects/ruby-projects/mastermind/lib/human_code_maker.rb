require_relative 'shared_constants'
require_relative 'utility_methods'
require_relative 'code_maker'

class HumanCodeMaker < CodeMaker # rubocop:disable Style/Documentation
  include SharedConstants
  include UtilityMethods

  def generate_code
    # puts "provide a secret code consisting of #{CODE_LENGTH} comma separated numbers ranging from 1 through 4 representing one of the possible colors: #{COLORS.join(', ')}.".colorize(mode: :bold) # rubocop:disable Layout/LineLength
    code = nil
    loop do
      display_code_input_description
      code = extract_code_from_input
      break if code
    end
    convert_code_to_colors(code)
  end

  def display_code_input_description
    puts "Provide a secret code represented by a #{CODE_LENGTH} comma-separated values of integers from 1 through #{COLORS.length} representing one of the possible colors: #{COLORS.join(', ')}.".colorize(mode: :bold) # rubocop:disable Layout/LineLength
  end

  def display_wrong_input_message
    puts 'Please provide only integers corresponding to the correct color that are ranging from 1 to 4..'.colorize(
      mode: :bold, color: :color
    )
  end
end
