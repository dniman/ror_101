# frozen_string_literal: true
require_relative 'routine'

class Subroutine0801 < Routine
  def run
    self.active = true

    while active?
      @menu.clear
      print menu
      printf '>> '
      index = gets.chomp.to_i

      return if index.zero?
    end
  end

  def menu
    text = []
    if App.stations.empty?
      <<~MENU
        Нет доступных станций

        Вы можете:
          0.Выйти в предыдущее меню
      MENU
    else
      App.stations.each_with_index { |station, index| text << "  #{index + 1}.#{station.name}" }

      <<~MENU
        Список доступных станций:
        #{text.join("\n")}

          0.Выйти в предыдущее меню
      MENU
    end
  end
end
