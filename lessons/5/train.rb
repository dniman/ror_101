# frozen_string_literal: true
require_relative 'manufacturerable'
require_relative 'instance_counter'
require 'byebug'

# Класс Route (Маршрут)
class Train
  include Manufacturerable
  include InstanceCounter

  def self.find(number)
    self.instances.detect {|train| train.instance_variable_get(:@number) == number }
  end

  attr_reader :carriages, :speed, :station, :route

  # number: Номер поезда
  def initialize(number)
    @number = number
    @carriages = []
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
  def pin_on(carriage)
    @carriages << carriage if @speed.zero? && (carriage.type == type)
  end

  # Может отцеплять вагон
  def pin_off(carriage)
    @carriages.delete_if { |item| item == carriage } if @speed.zero? && @carriages.count.positive?
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

  def title
    "#{type.capitalize} поезд №#{@number}. Вагонов - #{@carriages.size}"
  end

  def show
    puts title
  end
end
