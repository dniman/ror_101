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
    raise 'not implemented'
  end

  def occupied_space=(value)
    @occupied_space += value
  end

  def free_space
    space - occupied_space
  end

  def info
    "#{type.capitalize} вагон №#{number}. Свободно - #{free_space}, Занято - #{occupied_space}"
  end

  private

  def number
    @number ||= self.class.instances.select do |instance|
      instance.type == type
    end.size + 1
  end
end
