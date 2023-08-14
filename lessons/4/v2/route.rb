# Класс Route (Маршрут)
class Route
  # initial_station - Начальная станция
  # final_station - Конечная станция
  def initialize(initial_station, final_station)
    @stations = [initial_station, [], final_station]
  end

  def stations
    @stations.flatten
  end

  # Может удалять промежуточную станцию из списка
  def add(station)
    @stations[1] << station
  end

  # Может удалять промежуточную станцию из списка
  def delete(station)
    @stations[1].delete_if { |item| item.name == station.name }
  end

  def next_station(station)
    index = stations.find_index(station)
    return station if index.next >= stations.size

    stations[index.next]
  end

  def previous_station(station)
    index = stations.find_index(station)
    return station if index.pred.negative?

    stations[index.pred]
  end

  # Может выводить список всех станций по-порядку от начальной до конечной
  def show
    @stations.flatten.each do |station|
      puts "  #{station.name}"
    end
  end
end
