require 'debug'
require_relative 'shared_constants'

module UtilityMethods # rubocop:disable Style/Documentation
  include SharedConstants
  DEBUG = false

  def convert_to_i(str)
    Integer(str)
  rescue ArgumentError
    nil
  end

  def only_permitted_integers_present?(array)
    array.all? do |el|
      el = convert_to_i(el)
      el.is_a?(Integer) && el.between?(1, 4)
    end
  end

  def convert_color_index_to_color(index)
    COLORS[index]
  end

  def extract_code_from_input
    code = gets.split(/\s*,\s*|\s+/)
    unless only_permitted_integers_present?(code) && code_length_correct?(code)
      puts "Please provide only integers corresponding to the correct color that are ranging from 1 to #{CODE_LENGTH}.."
        .colorize(
          color: :red, mode: :bold
        )
      return nil
    end
    code.map { |el| convert_to_i(el) - 1 }
  end

  def code_length_correct?(code)
    code.length == CODE_LENGTH
  end

  def convert_code_to_colors(code)
    code.map do |el|
      convert_color_index_to_color(el)
    end
  end

  def convert_colors_to_code(colors)
    colors.map do |el|
      COLORS.find_index(el)
    end
  end
end
