# Класс Route (Маршрут)
class Train
  attr_reader :carriages, :speed, :station, :route

  # number: Номер поезда
  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
    @route = nil
    @station = nil
  end

  # Может набирать скорость
  def speed_up
    @speed += 1
  end

  # Может тормозить (сбрасывать скорость до нуля)
  def speed_down
    @speed -= 1 if @speed.positive?
  end

  # Может прицеплять вагон
  def pin_on(carriage)
    @carriages << carriage if @speed.zero?
  end

  # Может отцеплять вагон
  def pin_off(carriage)
    @carriages.delete_if {|item| item == carriage } if @speed.zero? && @carriages.count.positive?
  end

  # Может принимать маршрут следования
  # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте
  def route=(value)
    @route = value
    @station = value.nil? ? nil : @route.stations.first
    @station&.add_train(self)
  end

  def next_station
    return if @route.nil?

    @route.next_station(station)
  end

  def previous_station
    return if @route.nil?

    @route.previous_station(station)
  end

  def move_next_station
    return if station.nil?

    station.delete_train(self)

    @station = next_station

    station.add_train(self)
  end

  def move_previous_station
    return if station.nil?

    station.delete_train(self)

    @station = previous_station

    station.add_train(self)
  end
 
  # Тип поезда
  def type
    return "пассажирский" if passanger?
    return "грузовой" if cargo?
  end

  def cargo?
    self.instance_of?(CargoTrain)
  end

  def passanger?
    self.instance_of?(PassangerTrain)
  end

  def title
    "#{type.capitalize} поезд №#{@number}. Вагонов - #{@carriages.size}"
  end

  def show
    puts title
  end

  def initial_station?
    previous_station == station
  end

  def final_station?
    next_station == station
  end
end
