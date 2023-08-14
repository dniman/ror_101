# frozen_string_literal: true

require_relative 'routine'

class Subroutine06 < Routine
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

    printf 'Сколько вагонов отцепить?: '
    value = gets.chomp.to_i
    value.times do
      carriage = train.carriages.last
      train.pin_off(carriage)
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
