# frozen_string_literal: true
require_relative 'routine'

class Subroutine0301 < Routine
  def run
    text = []
    if App.stations.empty?
      menu = <<~MENU
        Нет доступных станций

        Вы можете:
          0.Выйти в предыдущее меню
      MENU

      self.active = true

      while active?
        @menu.clear
        print menu
        printf '>> '
        index = gets.chomp.to_i

        self.active = false if index.zero?
      end
    else
      App.stations.each_with_index { |station, index| text << "  #{index + 1}.#{station.name}" }

      menu = <<~MENU
        Список доступных станций:
        #{text.join("\n")}

        Вы можете:#{' '}
          1.Продолжить

          0.Выйти в предыдущее меню
      MENU

      self.active = true

      while active?
        print menu
        printf '>> '
        index = gets.chomp.to_i
        return if index.zero?

        case index
        when 1
          while true
            printf 'Введите наименование начальной станции: '
            value = gets.chomp
            initial_station = App.stations.detect { |station| station.name == value }
            next unless initial_station

            break
          end

          while true
            printf 'Введите наименование конечной станции: '
            value = gets.chomp
            final_station = App.stations.detect { |station| station.name == value }
            next unless final_station

            break
          end

          App.create_route(initial_station, final_station)

          self.active = false
        end
      end
    end
  end
end
