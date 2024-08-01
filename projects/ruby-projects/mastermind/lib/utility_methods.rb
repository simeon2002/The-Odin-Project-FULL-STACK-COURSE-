module UtilityMethods # rubocop:disable Style/Documentation
  def convert_to_i(str)
    Integer(str)
  rescue ArgumentError
    nil
  end

  def only_integers_present?(array)
    array.all? { |el| el.is_a?(Integer) }
  end
end
