#!/usr/bin/env ruby -w
# frozen_string_literal: true

# Класс Route (Маршрут)
class Station
  attr_reader :name

  # name - Наименование станции
  def initialize(name)
    @name = name
    @trains = []
  end

  # Может принимать поезда (по одному за раз)
  def add_train(value)
    @trains << value
  end

  # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции)
  def delete_train(value)
    @trains.delete_if { |train| train == value }
  end

  # Список всех поездов на станции
  def show_all
    @trains.each(&:show)
    puts "Итого: #{@trains.length}"
  end

  # Список пассажирских поездов
  def show_passanger
    trains = @trains.select(&:passanger?)
    trains.each(&:show)
    puts "Итого: #{trains.length}"
  end

  # Список грузовых поездов
  def show_cargo
    trains = @trains.select(&:cargo?)
    trains.each(&:show)
    puts "Итого: #{trains.length}"
  end
end

# Класс Route (Маршрут)
class Route
  # initial_station - Начальная станция
  # final_station - Конечная станция
  def initialize(initial_station, final_station)
    @stations = [initial_station, [], final_station]
  end

  def stations
    @stations.flatten
  end

  # Может удалять промежуточную станцию из списка
  def add(station)
    @stations[1] << station
  end

  # Может удалять промежуточную станцию из списка
  def delete(station)
    @stations[1].delete_if { |item| item.name == station.name }
  end

  def next_station(station)
    index = stations.find_index(station)
    return station if index.next >= stations.size

    stations[index.next]
  end

  def previous_station(station)
    index = stations.find_index(station)
    return station if index.pred.negative?

    stations[index.pred]
  end

  # Может выводить список всех станций по-порядку от начальной до конечной
  def show
    puts 'Список всех станций: '
    @stations.flatten.each do |station|
      puts "  #{station.name}"
    end
  end
end

# Класс Route (Маршрут)
class Train
  TRAIN_TYPE = {
    1 => 'Пассажирский',
    2 => 'Грузовой'
  }.freeze

  attr_reader :carriage_count, :speed, :station

  # number: Номер поезда
  # type: 1 - Пассажирский, 2 - Грузовой
  # carriage_count: Количество вагонов
  def initialize(number, type, carriage_count)
    @number = number
    @type = type
    @carriage_count = carriage_count
    @speed = 0
    @route = nil
    @station = nil
  end

  # Может набирать скорость
  def speed_up
    @speed += 1
  end

  # Может тормозить (сбрасывать скорость до нуля)
  def speed_down
    @speed -= 1 if @speed.positive?
  end

  # Может прицеплять вагон
  def pin_on
    @carriage_count += 1 if @speed.zero?
  end

  # Может отцеплять вагон
  def pin_off
    @carriage_count -= 1 if @speed.zero? && @carriage_count.positive?
  end

  # Может принимать маршрут следования
  # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте
  def route=(value)
    @route = value
    @station = value.nil? ? nil : @route.stations.first
    @station&.add_train(self)
  end

  def next_station
    return if @route.nil?

    @route.next_station(station)
  end

  def previous_station
    return if @route.nil?

    @route.previous_station(station)
  end

  def move_next_station
    return if station.nil?

    station.delete_train(self)

    @station = next_station

    station.add_train(self)
  end

  def move_previous_station
    return if station.nil?

    station.delete_train(self)

    @station = previous_station

    station.add_train(self)
  end

  # Является ли поезд пассажирским
  def passanger?
    @type == TRAIN_TYPE.keys.first
  end

  # Является ли поезд грузовым
  def cargo?
    @type == TRAIN_TYPE.keys.last
  end

  def show
    puts "#{TRAIN_TYPE[@type]} поезд №#{@number}. Вагонов - #{@carriage_count}"
  end
end

route = Route.new(Station.new('a'), Station.new('d'))
route.add Station.new('b')
route.add Station.new('c')

t1 = Train.new('FirstTrain', 1, 5)
t2 = Train.new('SecondTrain', 2, 35)
t1.route = route
t2.route = route

route.show
t1.station.show_cargo
t1.pin_on
t1.pin_on
t1.speed_up
pp t1
