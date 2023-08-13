# frozen_string_literal: true
require_relative 'routine'

class Subroutine02 < Routine
  def initialize
    super(menu)
  end

  def menu
    <<~MENU
      Вы можете:
        1.Добавить поезд
        2.Просмотреть список поездов
      #{'  '}
        0.Выйти в главное меню
    MENU
  end
end
