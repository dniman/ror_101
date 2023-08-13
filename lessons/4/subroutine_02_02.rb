# frozen_string_literal: true
require_relative 'routine'

class Subroutine0202 < Routine
  def run
    self.active = true

    while active?
      @menu.clear
      print menu
      print '>> '
      index = gets.chomp.to_i

      self.active = false if index.zero?
    end
  end

  def menu
    if App.trains.empty?
      <<~MENU
        Нет доступных поездов#{' '}

        Вы можете:
          0.Выйти в предыдущее меню
      MENU
    else
      text = []
      App.trains.each_with_index { |train, index| text << "  #{index + 1}.#{train.title}" }

      <<~MENU
        Список доступных поездов:
        #{text.join("\n")}

          0.Выйти в предыдущее меню
      MENU
    end
  end
end
