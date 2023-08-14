# frozen_string_literal: true
require_relative 'routine'

class Subroutine04 < Routine
  def run
    self.active = true

    while active?
      @menu.clear
      print routes_menu
      print '>> '
      index = gets.chomp.to_i

      return if index.zero?

      if (index - 1) <= App.routes.size && App.routes.size.positive?
        self.active = false
        route = App.routes[index - 1]
      end
    end

    self.active = true

    while active?
      print trains_menu
      print '>> '
      index = gets.chomp.to_i

      return if index.zero?

      if (index - 1) <= App.trains.size && App.trains.size.positive?
        self.active = false
        train = App.trains[index - 1]
      end
    end

    # Назначим маршрут поезду
    train.route = route
  end

  def routes_menu
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

  def trains_menu
    text = []
    if App.trains.empty?
      <<~MENU
        Нет доступных поездов#{' '}

        Вы можете:
          0.Выйти в предыдущее меню
      MENU
    else
      App.trains.each_with_index { |train, index| text << "  #{index + 1}.#{train.title}" }

      <<~MENU
        Список доступных поездов:
        #{text.join("\n")}

          0.Выйти в предыдущее меню
      MENU
    end
  end
end
