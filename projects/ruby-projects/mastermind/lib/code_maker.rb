require_relative 'shared_constants'
require_relative 'utility_methods'
# codemaker is a class that is containd inside of the game class,
# which is the entity that will create the codethat needs to be guesses and is part of the game.
class CodeMaker
  include SharedConstants
  include UtilityMethods

  # defined in sub classes
  def generate_code; end

  def provide_feedback(guess, code)
    debugger if DEBUG # rubocop:disable Lint/Debugger

    correct_positions_count = get_correct_positions_count(guess, code)

    correct_colors_count = get_correct_colors_count(guess, code)

    display_feedback_message(correct_colors_count, correct_positions_count)
  end

  def get_correct_positions(guess, code)
    # debugger if DEBUG
    guess.each_index.with_object([]) do |index, correct_indices|
      correct_indices << index if guess[index] == code[index]
    end
  end

  def get_correct_positions_count(guess, code)
    get_correct_positions(guess, code).length
  end

  def get_correct_colors_count(guess, code) # rubocop:disable Metrics/MethodLength
    correct_colors_count = 0

    # get all indices that are incorrectly positioned
    incorrect_positions = get_incorrect_positions(guess, get_correct_positions(guess, code))

    incorrect_positions.each do |index_of_guess|
      incorrect_positions.each do |index_of_code|
        next if index_of_code == index_of_guess

        if code[index_of_code] == guess[index_of_guess]
          correct_colors_count += 1
          break
        end
      end
    end

    correct_colors_count
  end

  def get_incorrect_positions(guess, correct_positions)
    guess.each_index.filter do |index|
      !correct_positions.include?(index)
    end
  end

  def display_feedback_message(colors_counts, positions_count)
    puts "you currently have #{positions_count} correct positions and #{colors_counts} correct colors that are in an incorrect positions." # rubocop:disable Layout/LineLength
  end
end
