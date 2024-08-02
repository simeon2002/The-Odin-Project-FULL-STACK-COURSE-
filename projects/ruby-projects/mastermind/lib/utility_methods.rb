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
    debugger if DEBUG
    array.all? do |el|
      el = convert_to_i(el)
      el.is_a?(Integer) && el.between?(1, 4)
    end
  end

  def convert_color_index_to_color(index)
    COLORS[index]
  end
end
