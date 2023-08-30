# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

# Класс Route (Маршрут)
class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  class << self
    alias all instances
  end

  validate :name, :presence
  validate :name, :type, String
  validate :name, :max, 10

  # name - Наименование станции
  def initialize(name)
    @name = name
    @trains = []

    validate!
  end

  # Может принимать поезда (по одному за раз)
  def add_train(value)
    @trains << value
  end

  # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции)
  def delete_train(value)
    @trains.delete_if { |train| train == value }
  end

  # Список пассажирских поездов/грузовых поездов
  def trains_by_type(type)
    @trains.map { |train| train.type == type }
  end

  def show_all
    each_train(&:show)
    puts "Всего поездов на станции: #{@trains.length}"
  end

  def each_train
    trains.each do |train|
      yield train if block_given?
    end
  end
end
