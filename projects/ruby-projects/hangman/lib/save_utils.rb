module SaveUtils # rubocop:disable Style/Documentation
  def convert_to_i(str)
    Integer(str)
  rescue ArgumentError
    nil
  end

  def extract_file_number
    loop do
      answer = convert_to_i(gets.chomp)
      return answer if !answer.nil? && (0...file_count).include?(answer)

      puts 'give a valid number'
    end
  end

  def fetch_saved_files
    Dir.new('saved_games').children
  end

  def file_count
    fetch_saved_files.length
  end

  def parse_file_from_yaml
    ScreenMessageUtility.display_files
    file_number = extract_file_number
    file_name = fetch_saved_files.at(file_number)
    path = "saved_games/#{file_name}"
    File.open(path, 'r')
  end
end
