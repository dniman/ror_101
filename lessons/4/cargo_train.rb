# frozen_string_literal: true

require_relative 'train'
require_relative 'cargo_carriage'

class CargoTrain < Train

  # Может прицеплять вагон
  def pin_on(carriage)
    super if cargo_carriage?(carriage)
  end
  
  # Может отцеплять вагон
  def pin_off(carriage)
    super
  end

  private

  # Делаем приватным потому что
  # используется только самим объектом
  def cargo_carriage?(carriage)
    carriage.instance_of?(CargoCarriage)
  end
end
