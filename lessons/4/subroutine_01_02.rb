# frozen_string_literal: true
require_relative 'routine'

class Subroutine0102 < Routine
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
    if App.stations.empty?
      <<~MENU
        Нет доступных станций

        Вы можете:
          0.Выйти в предыдущее меню
      MENU
    else
      text = []
      App.stations.each_with_index { |station, i| text << "  #{i + 1}.#{station.name}" }

      <<~MENU
        Список доступных станций:
        #{text.join("\n")}

          0.Выйти в предыдущее меню
      MENU
    end
  end
end
