# frozen_string_literal: true

require_relative 'text_menu'
require_relative 'route'

class RouteMenu < TextMenu
  def create_route_action
    if stations.size >= 1
      puts 'Выберите начальную станцию из списка: '
      puts show_stations(true)
      print '>> '
      num = gets.chomp.to_i
      initial_station = stations[num - 1]

      puts 'Выберите конечную станцию из списка: '
      available_stations = stations - [initial_station]
      available_stations.each.with_index(1) do |station, index|
        puts "  #{index}.#{station.name}"
      end
      print '>> '
      num = gets.chomp.to_i
      final_station = available_stations[num - 1]

      route = create_route(initial_station, final_station)
      puts "Добавлен новый маршрут #{route.stations.map(&:name).join('-')}"
    else
      puts show_stations
      puts 'Требуется две станции'
    end

    print 'Нажмите любую клавишу для продолжения...'
    gets
  end

  def show_routes_action
    puts show_routes
    print 'Нажмите любую клавишу для продолжения...'
    gets
  end

  def add_station_action
    if routes_count.positive?
      puts 'Выберите маршрут из списка: '
      puts show_routes(true)
      print '>> '
      num = gets.chomp.to_i

      route = routes[num - 1]

      available_stations = stations - route.stations
      if available_stations.size.positive?
        puts 'Выберите промежуточную станцию из списка: '
        available_stations.each.with_index(1) do |station, index|
          puts "  #{index}.#{station.name}"
        end
        print '>> '
        num = gets.chomp.to_i

        station = available_stations[num - 1]
        puts "Добавлен новая станция #{station.name} к маршруту #{route.stations.map(&:name).join('-')}"
        route.add(station)
      else
        puts show_stations
      end
    else
      puts show_routes
    end

    print 'Нажмите любую клавишу для продолжения...'
    gets
  end

  def delete_station_action
    if routes_count.positive?
      puts 'Выберите маршрут из списка: '
      puts show_routes(true)
      print '>> '
      num = gets.chomp.to_i

      route = routes[num - 1]

      available_stations = route.stations[-2..1]
      if available_stations.size.positive?
        puts 'Выберите промежуточную станцию из списка: '
        available_stations.each.with_index(1) do |station, index|
          puts "  #{index}.#{station.name}"
        end
        print '>> '
        num = gets.chomp.to_i

        station = available_stations[num - 1]
        puts "Удалена станция #{station.name} из маршрута #{route.stations.map(&:name).join('-')}"
        route.delete(station)
      else
        puts show_stations
      end
    else
      puts show_routes
    end

    print 'Нажмите любую клавишу для продолжения...'
    gets
  end

  private

  def stations
    $stations
  end

  def stations_count
    $stations.size
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
      arr << "Всего станций: #{stations_count}"
    end
    arr.join("\n")
  end

  def routes
    $routes
  end

  def routes_count
    $routes.size
  end

  def create_route(initial_station, final_station)
    route = Route.new(initial_station, final_station)
    routes << route
    route
  end

  def show_routes(index = false)
    arr = []
    if index
      routes.each.with_index(1) do |route, index|
        arr << "  #{index}.#{route.stations.map(&:name).join('-')}"
      end
    else
      routes.each do |route|
        arr << "  #{route.stations.map(&:name).join('-')}"
      end
      arr << "Всего маршрутов: #{routes_count}"
    end
    arr.join("\n")
  end
end
