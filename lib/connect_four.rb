# frozen_string_literal: true

require_relative 'player'
require_relative 'board'

# frozen_string_literal: true

# Connect Four
class ConnectFour
  attr_reader :players, :board

  def initialize
    @players = [Player.new(1), Player.new(2)]
    @board = Board.new
  end

  def start
    print_welcome
    @players[0].gets_name
    @players[1].gets_name
    @board.print_board
    play
  end

  def play
    until @board.full?
      puts "#{@players[0].name} #{@players[0].marker}, choose a column: "
      column = gets_column

      if column
        @board.place_marker(@players[0].marker, column)
        @board.print_board
        break if (win = winner?(@players[0].marker, column))
      end

      take_turns
    end

    game_end(win)
  end

  def game_end(win)
    if win
      puts "Congratulations #{@players[0].name}, you win!"
    else
      puts "It's a tie!"
    end

    gets_play_again
  end

  def gets_play_again
    puts 'Would you like to play again? (y/n)'
    ans = gets.chomp.downcase
    ConnectFour.new.start if ans == 'y'
  end

  def gets_column
    column = gets.chomp[0].to_i
    return column if column.between?(1, 7) && ! @board.col_full?(column)

    puts 'Invalid column choice.'
    nil
  end

  def take_turns
    @players[0], @players[1] = @players[1], @players[0]
  end

  def print_welcome
    puts "Welcome to Connect Four!\n"
  end

  def winner?(marker, col, combo = ''.dup)
    row = @board.bottom_empty_row(col) + 1
    4.times { combo << marker }

    vertical_win?(row, col, combo) ||
      horizontal_win?(row, col, combo) ||
      diagonal_win?(row, col, combo)
  end

  def vertical_win?(_row, col, combo)
    @board.column(col).join('').include?(combo)
  end

  def horizontal_win?(row, _col, combo)
    @board.row(row).join('').include?(combo)
  end

  def diagonal_win?(row, col, combo)
    @board.diagonal_plus(row, col).join('').include?(combo) ||
      @board.diagonal_minus(row, col).join('').include?(combo)
  end
end

ConnectFour.new.start
