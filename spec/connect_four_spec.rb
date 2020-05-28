# frozen_string_literal: true

require './lib/connect_four'

# Gameplay
#   Players should alternate turns
#   Board should be printed in between turns
#   Players should type a column number to place a piece
#   Game ends when board is full or when someone gets 4 in a row
#   Ask if they want to play again

describe ConnectFour do
  describe '#print_welcome' do
    it 'prints welcome message' do
      expect(STDOUT).to receive(:puts).with(
        "Welcome to Connect Four!\n" )
      subject.print_welcome
    end
  end

  describe '#gets_column' do 
    before do
      $stdin = StringIO.new("1")
    end

    it 'gets column 1' do
      expect(subject.gets_column).to eq(1)
    end
  end

  describe '#gets_columns' do 
    before do
      $stdin = StringIO.new("23")
    end

    describe 'choose invalid column' do
      it 'gets column 1' do
        expect(subject.gets_column).to eq(2)
      end
    end
  end

  describe '#gets_columns' do 
    before do
      $stdin = StringIO.new("k")
    end

    context 'choose invalid column' do
      it 'gets column 1' do
        expect(subject.gets_column).to eq(nil)
      end
    end
  end

  describe '#take_turns'do
    it 'player 2 goes second' do 
      expect(subject.take_turns[0].number).to eq(2)
    end

    it 'player 1 goes third' do 
      subject.take_turns
      expect(subject.take_turns[0].number).to eq(1)
    end
  end

  describe '#winner?' do 
    it 'returns true if 4 in a row - vertical 2-6' do
      4.times {subject.board.place_marker('●', 1)}
      expect(subject.winner?('●', 1)).to eq(true)      
    end

    it 'returns true if 4 in a row - vertical 1-4' do
      2.times {subject.board.place_marker('○', 1)}
      4.times {subject.board.place_marker('●', 1)}
      expect(subject.winner?('●', 1)).to eq(true)      
    end

    it 'returns false if 3 in a row - vertical' do
      3.times {subject.board.place_marker('●', 1)}
      expect(subject.winner?('●', 1)).to eq(false)      
    end

    it 'returns false if different markers in a row - vertical' do
      subject.board.place_marker('●', 1)
      subject.board.place_marker('●', 1)
      subject.board.place_marker('●', 1)
      subject.board.place_marker('○', 1)
      expect(subject.winner?('●', 1)).to eq(false)      
    end

    it 'returns true if 4 in a row - horizontal' do
      subject.board.place_marker('●', 1)
      subject.board.place_marker('●', 2)
      subject.board.place_marker('●', 3)
      subject.board.place_marker('●', 4)
      expect(subject.winner?('●', 4)).to eq(true)      
    end

    it 'returns true if 4 in a row - diagonal minus' do
      subject.board.place_marker('●', 1)
      subject.board.place_marker('○', 2)
      subject.board.place_marker('●', 2)
      subject.board.place_marker('○', 3)
      subject.board.place_marker('●', 3)
      subject.board.place_marker('●', 3)
      subject.board.place_marker('●', 4)
      subject.board.place_marker('○', 4)
      subject.board.place_marker('○', 4)
      subject.board.place_marker('●', 4)
      # subject.board.print_board
      expect(subject.winner?('●', 4)).to eq(true)      
    end

    it 'returns true if 4 in a row - diagonal plus' do
      subject.board.place_marker('○', 1)
      subject.board.place_marker('○', 1)
      subject.board.place_marker('○', 1)
      subject.board.place_marker('●', 1)
      subject.board.place_marker('○', 2)
      subject.board.place_marker('●', 2)
      subject.board.place_marker('●', 2)
      subject.board.place_marker('○', 3)
      subject.board.place_marker('●', 3)
      subject.board.place_marker('●', 4)
      # subject.board.print_board
      expect(subject.winner?('●', 4)).to eq(true)      
    end

  end
end
