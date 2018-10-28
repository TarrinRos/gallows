require "unicode_utils/downcase"

class Game
  attr_reader :errors, :letters, :good_letters, :bad_letters, :status
  attr_accessor :version

  MAX_ERRORS = 7

  def initialize(word)
    downcased_word = UnicodeUtils.downcase(word)
    @letters = get_letters(downcased_word)

    @errors = 0

    @good_letters = []
    @bad_letters = []

    @status = :in_progress #:won, :lost
  end

  def max_errors
    MAX_ERRORS
  end

  def errors_left
    MAX_ERRORS - @errors
  end

  def in_progress?
    @status == :in_progress
  end

  def won?
    @status == :won
  end

  def lost?
    @status == :lost || @errors >= MAX_ERRORS
  end

  def get_letters(downcased_word)
    if downcased_word == nil || downcased_word == ""
      abort 'Вы не ввели слово для игры'
    end

    downcased_word.split("")
  end

  # 1. спросить букву в консоли
  # 2. проверить результат
  def ask_next_letter
    puts "\n Введите следующую букву"
    letter = ""

    while letter == ""
      letter = STDIN.gets.chomp
      letter = UnicodeUtils.downcase(letter)
    end

    next_step(letter)
  end

  def is_good?(letter)
    @letters.include? letter ||
                        letter == "е" && @letters.include?("ё") ||
                        letter == "ё" && @letters.include?("е") ||
                        letter == "й" && @letters.include?("и") ||
                        letter == "и" && @letters.include?("й")
  end

  def add_letter_to(letters, letter)

    letters << letter

    case (letter)
    when ("е")
      letters << "ё"
    when ("ё")
      letters << "е"
    when ("и")
      letters << "й"
    when ("й")
      letters << "и"
    end

    return letters
  end

  def solved?
    (@letters - @good_letters).empty?
  end

  def repeated?(letter)
    @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  # Метод next_step должен проверить наличие буквы в загаданном слове
  # Или среди уже названных букв (массивы @good_letters, @bad_letters)
  # Аналог метода check_result в первой версии программы
  def next_step(letter)
    return if @status == :lost || @status == :won

    return if repeated?(letter)

    if is_good?(letter)
      add_letter_to(@good_letters, letter)

      # условие, когда отгадано все слово
      @status = :won if solved?
    else
      add_letter_to(@bad_letters, letter)
      @errors += 1

      @status = :lost if lost?
    end
  end
end
