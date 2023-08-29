# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validatable'

# Класс Route (Маршрут)
class Route
  include InstanceCounter
  include Validatable

  attr_reader :intermediate_stations

  # initial_station - Начальная станция
  # final_station - Конечная станция
  def initialize(initial_station, final_station)
    @initial_station = initial_station
    @final_station = final_station
    @intermediate_stations = []
    @stations = [initial_station, @intermediate_stations, final_station]

    validate!
  end

  def stations
    @stations.flatten
  end

  # Может удалять промежуточную станцию из списка
  def add(station)
    @intermediate_stations << station
  end

  # Может удалять промежуточную станцию из списка
  def delete(station)
    @intermediate_stations.delete_if { |item| item.name == station.name }
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
    @stations.flatten.each do |station|
      puts "  #{station.name}"
    end
  end

  private

  attr_reader :initial_station, :final_station

  def validate!
    raise 'Начальная станция не может быть пустой!' if initial_station.nil?
    raise 'Конечная станция не может быть пустой!' if final_station.nil?
  end
end
