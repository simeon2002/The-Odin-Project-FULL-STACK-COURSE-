# Class that stores state about the player and methods to interact with the player.
class Player
  attr_reader :symbol, :name

  def initialize(symbol)
    @name = ''
    @symbol = symbol
  end

  def get_name # rubocop:disable Naming/AccessorMethodName
    print 'Enter your name: '.colorize(mode: :bold)
    @name = gets.chomp.capitalize
    puts
  end
end
