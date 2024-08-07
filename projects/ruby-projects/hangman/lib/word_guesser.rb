class WordGuesser
  def extract_guess_from_input
    guess = nil
    loop do
      guess = gets.chomp.match(/[a-zA-Z]/).to_s.downcase
      break if guess # nil if no match is present! so it asks again.

      puts 'please provide a letter, no numbers or anything else!'
    end
    guess
  end
end
