# frozen_string_literal: true
require_relative 'routine'

class Subroutine0303 < Routine
  def run
    self.active = true

    while active?
      @menu.clear
      print routes_menu
      print '>> '
      index = gets.chomp.to_i

      return if index.zero?

      next unless (index - 1) <= App.routes.size && App.routes.size.positive?

      self.active = false

      route = App.routes[index - 1]
    end

    stations = App.stations - route.stations
    if stations.empty?
      stations_menu = <<~MENU
        Нет доступных станций

        Вы можете:
          0.Выйти в предыдущее меню
      MENU
    else
      text = []
      stations.each_with_index { |station, index| text << "  #{index + 1}.#{station.name}" }

      stations_menu = <<~MENU
        Список доступных станций:
        #{text.join("\n")}

          0.Выйти в предыдущее меню
      MENU
    end

    self.active = true

    while active?
      @menu.clear
      print stations_menu
      print '>> '
      index = gets.chomp.to_i

      return if index.zero?

      if index - 1 <= stations.size
        self.active = false
        station = stations[index - 1]
      end
    end

    route.add(station)
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
end
