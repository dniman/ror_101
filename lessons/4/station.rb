# Класс Route (Маршрут)
class Station
  attr_reader :name, :trains

  # name - Наименование станции
  def initialize(name)
    @name = name
    @trains = []
  end

  # Может принимать поезда (по одному за раз)
  def add_train(value)
    @trains << value
  end

  # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции)
  def delete_train(value)
    @trains.delete_if { |train| train == value }
  end

  # Список пассажирских поездов/грузовых поездов
  def trains_by_type(type)
    @trains.map {|train| train.type == type}
  end
end
