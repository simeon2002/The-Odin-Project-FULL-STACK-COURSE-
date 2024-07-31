require 'colorize'
require 'debug'
# Board class contains the grid that will be used for the game. This is stored in a 2-dim array.
# The board has two players' objects associated that are playing the game.
class Board
  def initialize
    @board_grid = Array.new(3) { |_| Array.new(3, ' ') }
  end

  def clear_grid
    self.board_grid = Array.new(3) { |_| Array.new(3, ' ') }
  end

  def display # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    (@board_grid.length + 2).times { |_| print '_'.colorize(mode: :bold) }
    (0...@board_grid.length).each do |i|
      puts ''
      (0...@board_grid[i].length).each do |j|
        print @board_grid[i][j].colorize(mode: :bold)
        print '|'.colorize(mode: :bold) unless j == @board_grid[i].length - 1
      end
    end
    puts
    (@board_grid.length + 2).times { |_| print '_'.colorize(mode: :bold) }
    puts
  end

  def full?
    board_grid.each do |row|
      row.each do |el|
        return false if el == ' '
      end
    end
    true
  end

  def player_won?(player)
    player_symbol = player.symbol
    winning_pattern_of_three?(player_symbol)
  end

  def winning_pattern_of_three?(symbol)
    board_grid.each_with_index do |row, row_ind|
      row.each_with_index do |el, col_ind|
        next if row_ind.even? && col_ind.even?
        return true if pattern_present?(symbol, row, row_ind, el, col_ind)
      end
    end
    false
  end

  def pattern_present?(symbol, row, row_ind, element, col_ind) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
    return false unless element == symbol # if element not matching, return.

    if element == symbol && ((row[col_ind + 1] == symbol &&
          row[col_ind - 1] == symbol) ||
         (board_grid[row_ind - 1][col_ind] == symbol &&
         board_grid[row_ind + 1][col_ind] == symbol) ||
         (board_grid[row_ind - 1][col_ind + 1] == symbol &&
         board_grid[row_ind + 1][col_ind - 1] == symbol) ||
         (board_grid[row_ind - 1][col_ind - 1] == symbol &&
         board_grid[row_ind + 1][col_ind + 1] == symbol))
      return true
    end

    false
  end

  def add_grid_element(player, row, column)
    board_grid[row][column] = player.symbol
  end

  def move_by_player(player)
    puts "It is #{player.name}'s turn. " \
         'Provide a play by specifying the row and column you want to put your marker.'.colorize(
           color: :green, mode: :bold
         )
    row, column = get_row_and_column
    add_grid_element(player, row, column)
    # board_grid.display
  end

  def grid_element_empty?(row, column)
    board_grid[row][column] == ' '
  end

  def get_row_and_column # rubocop:disable Naming/AccessorMethodName,Metrics/MethodLength
    while true
      print 'row: '
      row = gets.chomp.to_i - 1 # -1 to accoutn for position, i.e. 1x1 is index [0][0]
      next unless row.between?(0, 2)

      print 'column: '
      column = gets.chomp.to_i - 1 # -1 to accoutn for position, i.e. 1x1 is index [0][0]
      next unless column.between?(0, 2)

      break if grid_element_empty?(row, column) # move only possible if grid element is free.

      puts 'Element has already been filled! Give other coordinates please.'.colorize(color: :red, mode: :bold)
    end
    [row, column]
  end

  private

  attr_accessor :board_grid
end
