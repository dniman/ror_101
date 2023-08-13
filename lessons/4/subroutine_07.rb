# frozen_string_literal: true
require_relative 'routine'

class Subroutine07 < Routine
  def run
    self.active = true

    while active?
      print trains_menu
      print '>> '
      index = gets.chomp.to_i

      return if index.zero?

      next unless (index - 1) <= App.trains.size && App.trains.size.positive?

      self.active = false

      train = App.trains[index - 1]
    end

    menu = <<~MENU
      #{train.title}
      Маршрут поезда: #{train.route.stations.map(&:name).join('-')}
      Текущая станция: #{train.station.name}

    MENU

    if train.initial_station?
      menu_add = <<~MENU
        Вы можете:
          1.Переместить поезд на следующую станцию #{train.next_station.name}

          0.Выйти в предыдущее меню
      MENU
      printf menu
      printf menu_add
      printf '>> '
      index = gets.chomp.to_i
      return index if index.zero?

      train.move_next_station
    elsif train.final_station?
      menu_add = <<~MENU
        Вы можете:
          1.Переместить поезд на предыдущую станцию #{train.previous_station.name}

          0.Выйти в предыдущее меню
      MENU
      printf menu_add
      printf '>> '
      index = gets.chomp.to_i
      return index if index.zero?

      train.move_previous_station
    else
      menu_add = <<~MENU
        Вы можете:
          1.Переместить поезд на предыдущую станцию #{train.previous_station.name}
          2.Переместить поезд на следующую станцию #{train.next_station.name}

          0.Выйти в предыдущее меню
      MENU
      printf menu_add
      printf '>> '
      index = gets.chomp.to_i

      if index.zero?
        index
      elsif index == 1
        train.move_previous_station
      elsif index == 2
        train.move_next_station
      end
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
