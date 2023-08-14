# frozen_string_literal: true

require_relative 'train'
require_relative 'passanger_carriage'

class PassangerTrain < Train
  attr_reader :type 

  def initialize(number)
    super(number)
    @type = :passanger
  end
end
