# frozen_string_literal: true
require_relative 'routine'

class Subroutine03 < Routine
  def initialize
    super(menu)
  end

  def menu
    <<~MENU
      Вы можете:
        1.Добавить маршрут
        2.Просмотреть список маршрутов
        3.Добавить промежуточную станцию к маршруту
        4.Удалить промежуточную станцию из маршрута
      #{'  '}
        0.Выйти в главное меню
    MENU
  end
end
