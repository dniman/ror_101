# frozen_string_literal: true

require_relative 'train'
require_relative 'passanger_carriage'

class PassangerTrain < Train
  
  # Может прицеплять вагон
  def pin_on(carriage)
    super if passanger_carriage?(carriage)
  end

  # Может отцеплять вагон
  def pin_off(carriage)
    super
  end

  private
 
  # Делаем приватным потому что используется
  # только внутри самого объекта
  def passanger_carriage?(carriage)
    carriage.instance_of?(PassangerCarriage)
  end
end
