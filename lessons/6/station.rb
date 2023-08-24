# frozen_string_literal: true
require_relative 'instance_counter'

# Класс Route (Маршрут)
class Station
  include InstanceCounter
  include Validatable

  attr_reader :name, :trains

  class << self
    alias_method :all, :instances
  end

  # name - Наименование станции
  def initialize(name)
    @name = name
    @trains = []

    self.validate!
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
    @trains.each(&:show)
    puts "Всего поездов на станции: #{@trains.length}"
  end

  private

  def validate!
    raise "Наименование станции не может быть пустым!" if self.name.empty?
    raise "Наименование станции не божет быть больше 10 символов!" if self.name.length > 10
  end
end
