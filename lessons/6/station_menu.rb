# frozen_string_literal: true

require_relative 'text_menu'
require_relative 'station'

class StationMenu < TextMenu
  def create_station_action
    begin
      print 'Введите наименование станции: '
      name = gets.chomp

      station = create_station(name)
    rescue RuntimeError => error
      puts error.message
      retry
    end

    puts "Добавлена новая станция #{station.name}"
    print 'Нажмите любую клавишу для продолжения...'
    gets
  end

  def show_stations_action
    puts show_stations
    print 'Нажмите любую клавишу для продолжения...'
    gets
  end

  def show_station_trains_action
    if stations_count.positive?
      self.active = true
      while active?
        puts 'Выберите станцию из списка: '
        puts show_stations(true)
        print '>> '
        num = gets.chomp.to_i
        station = stations[num - 1]
       
        self.active = false unless station.nil?
      end
      
      station.show_all
    else
      puts show_stations
    end
    print 'Нажмите любую клавишу для продолжения...'
    gets
  end

  private

  def stations
    Station.all || []
  end

  def create_station(name)
    Station.new(name)
  end

  def stations_count
    stations.size
  end

  def show_stations(index = false)
    arr = []
    if index
      stations.each.with_index(1) do |station, index|
        arr << "  #{index}.#{station.name}"
      end
    else
      stations.each do |station|
        arr << "  #{station.name}"
      end
      arr << "Всего станций: #{stations.size}"
    end
    arr.join("\n")
  end
end
