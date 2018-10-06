require "unicode_utils/downcase"

class Game
  def initialize(slovo)
    dc_slovo = UnicodeUtils.downcase(slovo)
    @letters = get_letters(dc_slovo)

    @errors = 0

    @good_letters = []
    @bad_letters = []

    @status = 0
  end

  def get_letters(dc_slovo)
      if dc_slovo == nil || dc_slovo == ""
        abort 'Вы не ввели слово для игры'
      end

      return dc_slovo.split("")
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

  # Метод next_step должен проверить наличие буквы в загаданном слове
  # Или среди уже названных букв (массивы @good_letters, @bad_letters)
  # Аналог метода check_result в первой версии программы
  def next_step(bukva)
    if @status == -1 || @status == 1
      return
    end

    if @good_letters.include?(bukva) || @bad_letters.include?(bukva)
      return
    end

    if @letters.include? bukva ||
      bukva == "е" && @letters.include?("ё")||
      bukva == "ё" && @letters.include?("е")||
      bukva == "й" && @letters.include?("и")||
      bukva == "и" && @letters.include?("й")

      @good_letters << bukva

      if bukva == "е"
        @good_letters << "ё"
      end

      if bukva == "ё"
        @good_letters << "е"
      end

      if bukva == "и"
        @good_letters << "й"
      end

      if bukva == "й"
        @good_letters << "и"
      end

      # условие, когда отгадано все слово
      if (@letters - @good_letters).empty?
        @status = 1
      end
    else
      @bad_letters << bukva
      @errors += 1
      if @errors >= 7
        @status = -1
      end
    end
  end

  # Методы-геттеры
  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end

  def status
    @status
  end

  def errors
    @errors
  end
end
