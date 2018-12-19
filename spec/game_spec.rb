require 'game'
require 'unicode_utils/downcase'

describe Game do
  before :each do
    word = 'batman'
    @game = Game.new(word)
  end

  describe '#initialize' do
    it 'should assign instance variables' do
      expect(@game.errors).to eq 0
      expect(@game.good_letters).to eq []
      expect(@game.bad_letters).to eq []
      expect(@game.status).to eq :in_progress
    end
  end

  describe '#next_step' do
    it 'sets @status == :won, when all letters are correct' do
      %w(a t b m n).each do |letter|
        @game.next_step(letter)
      end
      expect(@game.status).to eq :won
    end

    it 'sets @status == :lost, when @errors >= MAX_ERRORS' do
      %w(s w j k o p d).each do |letter|
        @game.next_step(letter)
      end
      expect(@game.status).to eq :lost
    end

    it 'keeps @status == :in_progress, when @errors < MAX_ERRORS' do
      %w(s w j k o p).each do |letter|
        @game.next_step(letter)
      end
      expect(@game.status).to eq :in_progress
    end
  end
end