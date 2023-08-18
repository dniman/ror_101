# frozen_string_literal: true

require_relative 'train'

class PassangerTrain < Train
  attr_reader :type

  def initialize(number)
    super(number)
    @type = "пассажирский"
  end
end