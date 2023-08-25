# frozen_string_literal: true

require_relative 'instance_counter'

class Carriage
  include InstanceCounter

  attr_reader :space, :occupied_space

  def initialize(space)
    @space = space
    @occupied_space = 0
  end

  def occupy_space
    raise "not implemented"
  end

  def occupied_space=(value)
    @occupied_space += value
  end

  def free_space
    self.space - self.occupied_space
  end

  def info
    "#{self.type.capitalize} вагон №#{self.number}. Свободно - #{self.free_space}, Занято - #{self.occupied_space}"
  end

  private
  
  def number
    @number ||= self.class.instances.select do |instance| 
      instance.type == self.type
    end.size + 1
  end
end
