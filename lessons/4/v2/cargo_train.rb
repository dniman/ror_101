# frozen_string_literal: true

require_relative 'train'
require_relative 'cargo_carriage'

class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    super(number)
    @type = :cargo
  end
end
