# frozen_string_literal: true

require_relative 'text_menu'
require_relative 'station_menu'
require_relative 'train_menu'
require_relative 'route_menu'

class MainMenu < TextMenu
  def station_action
    @station_menu ||= StationMenu.new.tap do |m|
      m.header = 'Выберите действие: '
      m.sections << '  1. Создать станцию'
      m.sections << '  2. Просмотреть список доступных станций'
      m.sections << '  3. Просмотреть список поездов на станции'
      m.sections << '  0. Вернуться в предыдущее меню'
      m.footer = '>> '
      m.actions << :create_station_action
      m.actions << :show_stations_action
      m.actions << :show_station_trains_action
    end

    @station_menu.activate!
  end

  def train_action
    @train_menu = TrainMenu.new.tap do |m|
      m.header = 'Выберите действие: '
      m.sections << '  1. Создать поезд'
      m.sections << '  2. Просмотреть список доступных поездов'
      m.sections << '  3. Добавить вагоны к поезду'
      m.sections << '  4. Отцепить вагоны от поезда'
      m.sections << '  5. Назначить маршрут поезду'
      m.sections << '  6. Переместить поезд по маршруту вперед'
      m.sections << '  7. Переместить поезд по маршруту назад'
      m.sections << '  0. Вернуться в предыдущее меню'
      m.footer = '>> '
      m.actions << :create_train_action
      m.actions << :show_trains_action
      m.actions << :pin_on_carriage_action
      m.actions << :pin_off_carriage_action
      m.actions << :set_route_action
      m.actions << :move_next_station_action
      m.actions << :move_previous_station_action
    end

    @train_menu.activate!
  end

  def route_action
    @route_menu = RouteMenu.new.tap do |m|
      m.header = 'Выберите действие: '
      m.sections << '  1. Создать маршрут'
      m.sections << '  2. Просмотреть список маршрутов'
      m.sections << '  3. Добавить промежуточную станцию в маршрут'
      m.sections << '  4. Удалить промежуточную станцию с маршрута'
      m.sections << '  0. Вернуться в предыдущее меню'
      m.footer = '>> '
      m.actions << :create_route_action
      m.actions << :show_routes_action
      m.actions << :add_station_action
      m.actions << :delete_station_action
    end

    @route_menu.activate!
  end
end
