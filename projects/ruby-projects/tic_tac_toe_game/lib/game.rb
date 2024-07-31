require_relative 'player'
require_relative 'board'
require 'debug'

# Game class keeps track of the state of the game. The # rounds that will be played are stored here as well as the score
class Game
  def initialize
    @rounds = 5 # default value.
    @score = [0, 0]
    @player1 = Player.new('X')
    @player2 = Player.new('O')
    @board = Board.new
  end

  def setup_game
    puts 'SETUP PLAYER 1'.colorize(mode: :bold)
    puts '_______________'.colorize(mode: :bold)
    @player1.get_name

    puts 'SETUP PLAYER 2'.colorize(mode: :bold)
    puts '_______________'.colorize(mode: :bold)
    @player2.get_name

    prompt_rounds_to_play
  end

  def prompt_rounds_to_play
    loop do
      puts 'How many rounds do you want to play?'.colorize(mode: :bold)
      @rounds = gets.chomp.to_i
      break unless @rounds.zero?
    end
  end

  def play_game # rubocop:disable Metrics/MethodLength
    puts "\nSTARTING GAME".colorize(color: :blue, mode: :bold)
    sleep 1
    rounds.times do |round|
      round += 1
      play_round(round)
      board.display

      next if round == rounds

      message_intermediate_score(round)
      board.clear_grid
    end
    display_winner
  end

  def message_intermediate_score(round)
    puts "Round #{round} finished!"
    display_score
    puts
  end

  def play_round(round) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    puts "Round #{round}".colorize(mode: :bold)
    loop do
      if board.full?
        board.display
        score[0] += 1
        score[1] += 1
        return
      end

      # player 1 moves
      board.display
      board.move_by_player(player1)
      if board.player_won?(player1)
        score[0] += 1
        return
      end

      # player 2 moves
      board.display
      board.move_by_player(player2)
      if board.player_won?(player2)
        score[1] += 1
        return
      end
    end
  end

  def display_score # rubocop:disable Metrics/AbcSize
    if score[0] > score[1]
      puts "SCORE: #{score[0]}-#{score[1]} for #{player1.name}"
    elsif score[0] < score[1]
      puts "SCORE: #{score[1]}-#{score[0]} for #{player2.name}"
    else
      puts "SCORE: #{score[0]}-#{score[1]}, it's a draw!"
    end
  end

  def display_winner
    score_player1 = score[0]
    score_player2 = score[1]
    if score_player1 > score_player2 then puts "#{player1.name} won, congratulations!".colorize(color: :red)
    elsif score_player1 < score_player2 then puts "#{player2.name} won, congratulations!"
    else
      puts "It was a draw. #{player1.name} and #{player2.name}, good game!"
    end
  end

  def reset
    self.score = [0, 0]
    board.clear_grid
    prompt_rounds_to_play
  end

  private

  attr_accessor :rounds, :score
  attr_reader :board, :player1, :player2
end
