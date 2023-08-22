# frozen_string_literal: true

require_relative 'train_menu'
require_relative 'passanger_train'
require_relative 'cargo_train'

class TrainMenu < TextMenu
  PASSANGER_TRAIN = 1
  CARGO_TRAIN = 2

  def create_train_action
    begin
      print 'Введите номер поезда: '
      number = gets.chomp
      print 'Введите тип поезда(1-пассажирский, 2-грузовой): '
      type = gets.chomp.to_i
      
      train = create_train(number, type)
    rescue RuntimeError => error
      puts error.message
      retry  
    end

    puts "Добавлен новый #{train.title}"
    print 'Нажмите любую клавишу для продолжения...'
    gets
  end

  def show_trains_action
    puts show_trains
    print 'Нажмите любую клавишу для продолжения...'
    gets
  end

  def pin_on_carriage_action
    if trains_count.positive?
      puts 'Выберите поезд из списка: '
      puts show_trains(true)
      print '>> '
      num = gets.chomp.to_i

      train = trains[num - 1]

      if train.type == 'пассажирский'
        train.pin_on(PassangerCarriage.new)
      else
        train.pin_on(CargoCarriage.new)
      end
      puts "Прицеплен новый вагон к #{train.title}"
    else
      puts show_trains
    end
    print 'Нажмите любую клавишу для продолжения...'
    gets
  end

  def pin_off_carriage_action
    if trains_count.positive?
      puts 'Выберите поезд из списка: '
      puts show_trains(true)
      print '>> '
      num = gets.chomp.to_i

      train = trains[num - 1]

      train.pin_off(train.carriages.last)
      puts "Отцеплен вагон от #{train.title}"
    else
      puts show_trains
    end
    print 'Нажмите любую клавишу для продолжения...'
    gets
  end

  def set_route_action
    if trains_count.positive?
      puts 'Выберите поезд из списка: '
      puts show_trains(true)
      print '>> '
      num = gets.chomp.to_i

      train = trains[num - 1]

      if routes_count.positive?
        puts 'Выберите маршрут из списка: '
        puts show_routes(true)
        print '>> '
        num = gets.chomp.to_i

        train.route = routes[num - 1]
      else
        puts show_routes
      end
    else
      puts show_trains
    end

    print 'Нажмите любую клавишу для продолжения...'
    gets
  end

  def move_next_station_action
    if trains_count.positive?
      puts 'Выберите поезд из списка: '
      puts show_trains(true)
      print '>> '
      num = gets.chomp.to_i

      train = trains[num - 1]

      train.move_next_station
      puts "Поезд перемещен на станцию #{train.station}"
    else
      puts show_trains
    end
    print 'Нажмите любую клавишу для продолжения...'
    gets
  end

  def move_previous_station_action
    if trains_count.positive?
      puts 'Выберите поезд из списка: '
      puts show_trains(true)
      print '>> '
      num = gets.chomp.to_i

      train = trains[num - 1]

      train.move_previous_station
      puts "Поезд перемещен на станцию #{train.station}"
    else
      puts show_trains
    end
    print 'Нажмите любую клавишу для продолжения...'
    gets
  end

  private

  def trains
    (CargoTrain.instances.nil? ? [] : CargoTrain.instances) + \
      (PassangerTrain.instances.nil? ? [] : PassangerTrain.instances)
  end

  def trains_count
    trains.size
  end

  def routes
    Route.instances
  end

  def routes_count
    routes.size
  end

  def create_train(number, type)
    case type
    when PASSANGER_TRAIN
      PassangerTrain.new(number)
    when CARGO_TRAIN
      CargoTrain.new(number)
    else
      raise "Поезда с таким типом не существует!"
    end
  end

  def show_trains(index = false)
    arr = []
    if index
      trains.each.with_index(1) do |train, index|
        arr << "  #{index}.#{train.title}"
      end
    else
      trains.each do |train|
        arr << "  #{train.title}"
      end
      arr << "Всего поездов: #{trains.size}"
    end
    arr.join("\n")
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
