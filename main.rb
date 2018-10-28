require_relative 'lib/game'
require_relative 'lib/result_printer'

VERSION = "Игра 'Виселица' v.5.0.1"

current_path = File.dirname(__FILE__)

file_name = "#{current_path}/data/words.txt"

if File.exists?(file_name)
  word = File.readlines(file_name).sample.strip
else
  nil
end

game = Game.new(word)

game.version = VERSION

printer = ResultPrinter.new(game, current_path)

while game.in_progress? do
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)
