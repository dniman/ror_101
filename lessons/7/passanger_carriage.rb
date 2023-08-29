# frozen_string_literal: true

require_relative 'carriage'

class PassangerCarriage < Carriage
  MAX_SEATS = 40

  attr_reader :type

  def initialize
    @type = 'пассажирский'
    super(MAX_SEATS)
  end

  def occupy_space(space = 1)
    return if space > 1
    raise 'Мест в вагоне больше нет' if free_space.zero?

    self.occupied_space = space
  end
end
