# frozen_string_literal: true

require_relative 'carriage'

class CargoCarriage < Carriage
  MAX_CAPACITY = 1000

  attr_reader :type

  def initialize
    @type = 'грузовой'
    super(MAX_CAPACITY)
  end

  def occupy_space(space)
    raise "Запрашиваемый объем #{space} не доступен. Доступно #{free_space}" if space > free_space

    self.occupied_space = space
  end
end
