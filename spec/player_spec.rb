# frozen_string_literal: true

require './lib/player'

# Player
#   Player has a number 1 or 2
#   Player has a marker ● or ○
#   Player could have a name

describe 'Player' do
  before do
    @player_one = Player.new(1)
    @player_two = Player.new(2)
  end

  describe '#initialize player' do
    it 'Player 1 number is 1' do
      expect(@player_one.number).to eq(1)
    end

    it 'Player 2 number is 2' do
      expect(@player_two.number).to eq(2)
    end

    it 'Player 1 marker is ●' do
      expect(@player_one.marker).to eq('●')
    end

    it 'Player 2 marker is ○' do
      expect(@player_two.marker).to eq('○')
    end
  end

  describe '#gets_name' do
    before do
      $stdin = StringIO.new("Rain\n")
    end

    it 'sets name to inputted name' do
      @player_one.gets_name
      expect(@player_one.name).to eq('Rain')
    end
  end

  describe '#gets name with no name' do
    before do
      $stdin = StringIO.new("\n")
    end

    it 'sets name to Player 1 if no name input' do
      @player_one.gets_name
      expect(@player_one.name).to eq('Player 1')
    end
  end
end
