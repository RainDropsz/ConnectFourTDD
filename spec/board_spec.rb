# frozen_string_literal: true

require './lib/board'

# Board
#   6 rows x 7 columns (7 rows, 8 columns so index can start at 1)
#   Board should print
#   Board should accept marker placements for columns 1-7
#   Board should return the marker at a position
#   Board should tell if it is full

describe Board do
  describe '#initialize' do
    it 'has 7 rows' do
      expect(subject.num_rows).to eq(7)
    end

    it 'has 8 columns' do
      expect(subject.num_cols).to eq(8)
    end

    it 'spot 1,1 is _' do
      expect(subject.at(1, 1)).to eq('_')
    end

    it 'spot 5,5 is _' do
      expect(subject.at(5, 5)).to eq('_')
    end

    it 'spot 6,7 is _' do
      expect(subject.at(6, 7)).to eq('_')
    end
  end

  describe '#bottom_empty_row' do 
    it 'returns index 6 on empty column' do 
      expect(subject.bottom_empty_row(5)).to eq(6)
    end

    it 'returns index 1 on a 5-marker column' do 
      5.times {subject.place_marker('●', 3)}
      expect(subject.bottom_empty_row(3)).to eq(1)
    end

    it 'returns index 0 on af full column' do 
      6.times {subject.place_marker('●', 3)}
      expect(subject.bottom_empty_row(3)).to eq(0)
    end
  end

  describe '#place_marker' do
    it 'places first marker in bottom row' do
      subject.place_marker('●', 3)
      expect(subject.at(6, 3)).to eq('●')
    end

    it 'stacks two markers in last column' do
      subject.place_marker('●', 7)
      subject.place_marker('○', 7)
      expect(subject.at(5, 7)).to eq('○')
    end
  end

  describe '#print_board' do
    it 'prints empty board' do
      expect(STDOUT).to receive(:puts).with(
        '     |_|_|_|_|_|_|_|' + "\n" \
        '     |_|_|_|_|_|_|_|' + "\n" \
        '     |_|_|_|_|_|_|_|' + "\n" \
        '     |_|_|_|_|_|_|_|' + "\n" \
        '     |_|_|_|_|_|_|_|' + "\n" \
        '     |_|_|_|_|_|_|_|' + "\n" \
        '      1 2 3 4 5 6 7 ' + "\n"
      )

      subject.print_board
    end

    it 'prints board with markers' do
      subject.place_marker('●', 1)
      subject.place_marker('○', 1)
      subject.place_marker('●', 5)
      expect(STDOUT).to receive(:puts).with(
        '     |_|_|_|_|_|_|_|' + "\n" \
        '     |_|_|_|_|_|_|_|' + "\n" \
        '     |_|_|_|_|_|_|_|' + "\n" \
        '     |_|_|_|_|_|_|_|' + "\n" \
        '     |○|_|_|_|_|_|_|' + "\n" \
        '     |●|_|_|_|●|_|_|' + "\n" \
        '      1 2 3 4 5 6 7 ' + "\n"
      )

      subject.print_board
    end

    it 'prints six markers in first column' do
      3.times do
        subject.place_marker('●', 1)
        subject.place_marker('○', 1)
      end

      expect(STDOUT).to receive(:puts).with(
        '     |○|_|_|_|_|_|_|' + "\n" \
        '     |●|_|_|_|_|_|_|' + "\n" \
        '     |○|_|_|_|_|_|_|' + "\n" \
        '     |●|_|_|_|_|_|_|' + "\n" \
        '     |○|_|_|_|_|_|_|' + "\n" \
        '     |●|_|_|_|_|_|_|' + "\n" \
        '      1 2 3 4 5 6 7 ' + "\n"
      )

      subject.print_board
    end
  end

  describe '#full?' do
    it 'returns true if board is full' do
      3.times do
        1.upto(7) do |i|
          subject.place_marker('●', i)
          subject.place_marker('○', i)
        end
      end
      expect(subject.full?).to eq(true)
    end

    it 'returns false if board is empty' do
      expect(subject.full?).to eq(false)
    end

    it 'returns false if board has 2 pieces' do
      1.upto(7) do |i|
        subject.place_marker('●', i)
        subject.place_marker('○', i)
      end
      expect(subject.full?).to eq(false)
    end
  end 

  describe '#col_full?' do 
    it 'returns false if column is not full' do 
      expect(subject.col_full?(7)).to eq(false)
    end

    it 'returns true if column is full' do 
      3.times do
        subject.place_marker('●', 7)
        subject.place_marker('○', 7)
      end
      expect(subject.col_full?(7)).to eq(true)
    end
  end

  describe '#row' do
    it 'returns a row' do 
      subject.place_marker('●', 1)
      subject.place_marker('○', 2)
      subject.place_marker('●', 3)
      subject.place_marker('○', 4)

      expect(subject.row(6)).to eq(%w[● ○ ● ○ _ _ _])
    end
  end

  describe '#diagonal_plus' do
    it 'returns diagonal plus array' do 
      6.times {subject.place_marker('●', 1)}
      5.times {subject.place_marker('○', 2)}
      4.times {subject.place_marker('●', 3)}
      3.times {subject.place_marker('○', 4)}
      # puts "\n"
      # subject.print_board

      expect(subject.diagonal_plus(1, 1)).to eq(%w[● ○ ● ○ _ _])      
    end
  end

  describe '#diagonal_minus' do
    it 'returns diagonal minus array' do 
      6.times {subject.place_marker('●', 1)}
      5.times {subject.place_marker('○', 2)}
      4.times {subject.place_marker('●', 3)}
      3.times {subject.place_marker('○', 4)}

      expect(subject.diagonal_minus(3, 3)).to eq(%w[_ _ ● ○ ●])      
    end
  end

end
