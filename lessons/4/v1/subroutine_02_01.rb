# frozen_string_literal: true
require_relative 'routine'

class Subroutine0201 < Routine

  def run
    print 'Введите номер поезда: '
    number = gets.chomp.to_i
    print 'Введите тип поезда(1-пассажирский, 2-грузовой): '
    type = gets.chomp.to_i

    App.create_train(number,type)
  end
end
