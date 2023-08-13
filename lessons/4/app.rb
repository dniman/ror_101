# frozen_string_literal: true

require_relative 'routine'
require_relative 'station'
require_relative 'cargo_train'
require_relative 'passanger_train'
require_relative 'route'

# Главный класс приложения
class App < Routine
  PASSANGER_TRAIN = 1
  CARGO_TRAIN = 2

  @stations = []
  @trains = []
  @routes = []

  class << self
    attr_reader :stations, :trains, :routes

    def create_station(station)
      App.stations << Station.new(station)
    end

    def create_train(number, type)
      @trains << PassangerTrain.new(number) if type == PASSANGER_TRAIN
      @trains << CargoTrain.new(number) if type == CARGO_TRAIN
    end

    def create_root(initial_station, final_station)
      App.routes << Route.new(initial_station, final_station)
    end
  end

  def initialize
    super(main)
  end

  def main
    <<~MENU
      Вы можете:
        1.Создать станцию
        2.Создать поезд
        3.Создать маршрут
        4.Назначить маршрут поезду
        5.Добавить вагоны к поезду
        6.Отцепить вагоны от поезда
        7.Переместить поезд по маршруту
        8.Просмотреть список станций/список поездов на станции

        0.Выход
    MENU
  end
end
