module GameUtils # rubocop:disable Style/Documentation
  NUMBER_OF_GUESSES = 16

  def add_char_to_guess(char_guess)
    char_indices = store_indices_in_word_of(char_guess)
    char_indices.each do |index|
      word_guessed[index] = char_guess
    end
  end

  def retrieve_player_guess
    prompt_player_move
    word_guesser.extract_guess_from_input
  end

  def store_indices_in_word_of(char)
    char_indices = []
    word_generated.each_index { |i| char_indices << i if word_generated[i] == char }
    char_indices
  end

  def char_present?(char_guess)
    word_generated.include?(char_guess)
  end

  def char_already_tried?(char_guess)
    chars_tried.include?(char_guess)
  end

  def wrong_guess_count
    guesses_taken = NUMBER_OF_GUESSES - guess_count

    guesses_taken - correct_guess_count
  end

  def player_lost?
    # debugger
    guess_count.zero?
  end

  def player_won?
    word_generated == word_guessed
  end

  def end_of_game?
    if player_lost?
      display_player_lost
      true
    elsif player_won?
      display_player_won
      true
    else
      false
    end
  end
end
