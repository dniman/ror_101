# frozen_string_literal: true

require_relative 'carriage'

class CargoCarriage < Carriage
  def type
    :cargo
  end
end
