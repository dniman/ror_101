# frozen_string_literal: true
require_relative 'routine'

class Subroutine08 < Routine
  def initialize
    super(menu)
  end

  def menu
    <<~MENU
      Вы можете:
        1.Просмотреть список станций
        2.Просмотреть список поездов на станции
      #{'  '}
        0.Выйти в главное меню
    MENU
  end
end
