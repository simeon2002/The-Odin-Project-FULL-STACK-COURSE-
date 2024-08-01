require_relative 'shared_constants'
# codemaker is a class that is containd inside of the game class,
# which is the entity that will create the codethat needs to be guesses and is part of the game.
class CodeMaker
  include SharedConstants

  def generate_code
    code = []
    CODE_LENGTH.times do |i|
      code[i] = COLORS[rand(0...(COLORS.length))]
    end
    code
  end

  def provide_feedback(guess, code); end
end
