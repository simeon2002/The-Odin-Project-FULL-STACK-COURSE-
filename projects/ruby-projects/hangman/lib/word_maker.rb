class WordMaker # rubocop:disable Style/Documentation
  def generate_word
    words = parse_dictionary_file
    words.sample
  end

  def parse_dictionary_file
    file = File.new('google_10000_english_no_swears.txt')
    if File.exist?(file)
      file.readlines(chomp: true).filter { |el| el.length >= 5 && el.length <= 12 }
    else
      puts 'File doesn\'t exist!'
    end
  end
end
