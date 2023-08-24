# frozen_string_literal: true

require_relative 'carriage'

class CargoCarriage < Carriage
  MAX_CAPACITY = 20

  attr_reader :type, :capacity, :taked_capacity

  def initialize(capacity)
    @type = "грузовой"
    @capacity = capacity
    @taked_capacity = 0

    self.validate!
  end

  def take_up(capacity)
    raise "Запрашиваемый объем #{capacity} не доступен. Доступно #{self.capacity}" if capacity > self.capacity
    
    self.taked_capacity = capacity
  end

  def info
    "#{self.type.capitalize} ваган №#{self.number}. Свободно - #{self.capacity}, Занято - #{self.taked_capacity}"
  end

  private
  
  def number
    @number ||= self.class.instances.select do |instance| 
      instance.type == self.type
    end.size + 1
  end

  def taked_capacity=(value)
    @taked_capacity += value
    @capacity -= value
  end

  def validate!
    raise "Общий объем не может быть пустым!" if self.capacity.nil?
    raise "Общий объем не может быть больше #{MAX_CAPACITY}!" if self.capacity > MAX_CAPACITY
  end
end
