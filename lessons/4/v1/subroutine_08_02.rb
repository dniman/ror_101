# frozen_string_literal: true
require_relative 'routine'

class Subroutine0802 < Routine
  def run
    self.active = true

    while active?
      @menu.clear
      print menu
      printf '>> '
      index = gets.chomp.to_i

      return if index.zero?

      if (index - 1) <= App.stations.size && App.stations.size.positive?
        self.active = false
        station = App.stations[index - 1]
      end
    end

    self.active = true

    while active?
      if station.trains.empty?
        train_menu = <<~MENU
          Нет доступных станций

          Вы можете:
            0.Выйти в предыдущее меню
        MENU
      else
        text = []
        station.trains.each_with_index { |train, index| text << "  #{index + 1}.#{train.title}" }
        train_menu = <<~MENU
          Список поездов на станции:
          #{text.join("\n")}

          Вы можете:
            0.Выйти в предыдущее меню
        MENU
      end
      print train_menu

      print '>> '
      index = gets.chomp.to_i

      self.active = false if index.zero?
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
