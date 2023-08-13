# frozen_string_literal: true
require_relative 'routine'

class Subroutine0302 < Routine
  def run
    self.active = true

    while active?
      @menu.clear
      print menu
      printf '>> '
      index = gets.chomp.to_i

      self.active = false if index.zero?
    end
  end

  def menu
    text = []
    if App.routes.empty?
      <<~MENU
        Нет доступных маршрутов

        Вы можете:
          0.Выйти в предыдущее меню
      MENU
    else
      App.routes.each_with_index { |route, index| text << "  #{index + 1}.#{route.stations.map(&:name).join('-')}" }

      <<~MENU
        Список доступных маршрутов:
        #{text.join("\n")}

          0.Выйти в предыдущее меню
      MENU
    end
  end
end
