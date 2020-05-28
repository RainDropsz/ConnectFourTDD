# frozen_string_literal: true

# Connect Four Board
class Board
  def initialize
    @board = Array.new(7) { Array.new(8, nil) }
    1.upto(6) do |i|
      1.upto(7) do |j|
        @board[i][j] = '_'
      end
    end
  end

  def at(row, col)
    @board[row][col]
  end

  def place_marker(marker, col)
    row = bottom_empty_row(col)
    @board[row][col] = marker if row
  end

  def print_board(str = ''.dup)
    @board[1..6].each do |col|
      str << '     |' << col[1..7].join('|') << '|' << "\n"
    end

    # Labels for columns
    str << '      1 2 3 4 5 6 7 ' << "\n"

    puts str
  end

  def full?(result = true)
    1.upto(6) do |i|
      1.upto(7) do |j|
        return false if @board[i][j] == '_'
      end
    end

    result
  end

  def col_full?(col)
    @board[1][col] != '_'
  end

  def bottom_empty_row(col, arr = [])
    @board[1..6].each { |row| arr << row[col] }
    arr.rindex('_') ? arr.rindex('_') + 1 : 0
  end

  def row(row, arr = [])
    @board[row].each_with_index { |e, i| arr << e if i >= 1 }
    arr
  end

  def column(col, arr = [])
    @board[1..6].each { |row| arr << row[col] }
    arr
  end

  def start_pos_plus(row, col)
    col - (row - 1) >= 1 ? [1, col - (row - 1)] : [row - (col - 1), 1]
  end

  def diagonal_plus(row, col, arr = [])
    pos = start_pos_plus(row, col)

    0.upto(7) do |i|
      arr << @board[pos[0] + i][pos[1] + i]
      break if pos[0] + i == 6 || pos[1] + i == 7
    end

    arr
  end

  def start_pos_minus(row, col)
    col + (row - 1) <= 7 ? [1, col + (row - 1)] : [row - (7 - col), 7]
  end

  def diagonal_minus(row, col, arr = [])
    pos = start_pos_minus(row, col)

    0.upto(7) do |i|
      arr << @board[pos[0] + i][pos[1] - i]
      break if pos[0] + i == 6 || pos[1] - i == 1
    end

    arr
  end

  def num_rows
    @board.size
  end

  def num_cols
    @board[1].size
  end
end
