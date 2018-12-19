require 'game'
require 'result_printer'

describe ResultPrinter do
  before :each do
    @current_path = File.dirname(__FILE__)
    word = 'batman'
    @game = Game.new(word)
    @result = ResultPrinter.new(@game, @current_path)
  end

  describe '#print_status' do
    it 'should print won message' do
      %w(a t b m n).each do |letter|
        @game.next_step(letter)
      end
      expect(@result.print_status(@game)).to eq "Поздравляем! Вы выиграли!"
    end
  end
end