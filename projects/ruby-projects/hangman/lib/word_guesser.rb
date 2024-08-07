class WordGuesser # rubocop:disable Style/Documentation
  def extract_guess_from_input
    guess = nil
    loop do
      guess = gets.chomp.downcase
      break if guess == 'save'

      guess = guess.match(/[a-zA-Z]/).to_s
      break if guess.length == 1

      puts 'please provide a letter, no numbers or anything else!'
    end
    guess
  end
end
