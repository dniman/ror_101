# frozen_string_literal: true
require_relative 'routine'

class Subroutine01 < Routine
  def initialize
    super(menu)
  end

  def menu
    <<~MENU
      Вы можете:
        1.Добавить станцию
        2.Просмотреть список станций
      #{'  '}
        0.Выйти в главное меню
    MENU
  end
end
