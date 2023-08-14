require_relative 'station'
require_relative 'passanger_train'
require_relative 'cargo_train'
require_relative 'route'
require 'byebug'

menu =<<~MENU
  Вы можете:
    1.Создать станцию
    2.Создать поезд
    3.Создать маршрут
    4.Назначить маршрут поезду
    5.Добавить вагоны к поезду
    6.Отцепить вагоны от поезда
    7.Переместить поезд по маршруту
    8.Просмотреть список станций/список поездов на станции
    0.Выход
MENU

menu_01 =<<~MENU
  Вы можете:
    1.Добавить станцию
    2.Просмотреть список станций
    
    0.Выйти в главное меню
MENU



previous_menu =<<~MENU

  0.Выйти в предыдущее меню\n
MENU


class Menu
  def initialize(message)
    @message = message
  end
end

class MainMenu < Menu
  def initialize
    menu =<<~MENU
      Вы можете:
        1.Создать станцию
        2.Создать поезд
        3.Создать маршрут
        4.Назначить маршрут поезду
        5.Добавить вагоны к поезду
        6.Отцепить вагоны от поезда
        7.Переместить поезд по маршруту
        8.Просмотреть список станций/список поездов на станции
        0.Выход
    MENU

    super(menu)
  end

  def start
    self.active = true
    while active?
    end
  end

  def active?

  end

  def active=(value)
    @active = value
  end
end

menu = MainMenu.new




stations = []
trains = []
routes = []

loop do
  printf menu
  printf ">> "
  number = gets.chomp.to_i
  system "clear"

  case number
  when 0
    exit
  when 1
    exit_marker = true
    while exit_marker do
      printf menu_01
      printf ">> "
      subnumber = gets.chomp.to_i
   
      case subnumber
      when 0
        exit_marker = false
      when 1
        printf "Введите наименование станции: "
        station = gets.chomp

        stations << Station.new(station)
      when 2
        printf "Список доступных станций:\n"
        stations.each_with_index {|station, index| puts "#{index + 1}.#{station.name}"}
        printf previous_menu
        printf ">> "
        next if gets.chomp.to_i.zero?
      end
    end
    system "clear"
  when 2
    printf "Введите номер поезда: "
    number = gets.chomp.to_i
    printf "Введите тип поезда(1-пассажирский, 2-грузовой): "
    type = gets.chomp.to_i

    trains << 
      if type == Train::TRAIN_TYPE.keys.first
        PassangerTrain.new(number)
      else
        CargoTrain.new(number)
      end
    system "clear"
  when 3
    while true do
      printf "Введите наименование начальной станции: "
      value = gets.chomp
      initial_station = stations.detect{|station| station.name == value}
      next unless initial_station
      break
    end

    while true do
      printf "Введите наименование конечной станции: "
      value = gets.chomp
      final_station = stations.detect{|station| station.name == value }
      next unless final_station
      break
    end

    routes << Route.new(initial_station, final_station)
    system "clear"
  when 4
    if routes.size.zero?
      printf "Нет доступных маршрутов" 
      printf previous_menu
      printf ">> "
      next if gets.chomp.to_i.zero? 
    else
      printf "Доступны следующие маршруты:\n"
      routes.each_with_index {|route, index| puts "#{index + 1}.#{route.stations.map(&:name).join('-')}"}
      printf ">> "
      index = gets.chomp.to_i
      route = routes[index - 1]
    end
    
    if trains.size.zero?
      printf "Нет доступных поездов" 
      printf previous_menu
      printf ">> "
      next if gets.chomp.to_i.zero? 
    else
      printf "Доступны следующие поезда:\n"
      trains.each_with_index {|train, index| puts "#{index + 1}.#{train.title}"}
      printf ">> "
      index = gets.chomp.to_i
      train = trains[index - 1]
    end
    
    train.route = route
    system "clear"
  when 5
    if trains.size.zero?
      printf "Нет доступных поездов" 
      printf previous_menu
      printf ">> "
      next if gets.chomp.to_i.zero? 
    else
      printf "Доступны следующие поезда:\n"
      trains.each_with_index {|train, index| puts "#{index + 1}.#{train.title}"}
      printf ">> "
      index = gets.chomp.to_i
      train = trains[index - 1]
    end
    system "clear"
    printf "Сколько вагонов добавить?: "
    value = gets.chomp.to_i
    value.times{ train.pin_on }
    system "clear"
  when 6
    if trains.size.zero?
      printf "Нет доступных поездов" 
      printf previous_menu
      printf ">> "
      next if gets.chomp.to_i.zero? 
    else
      printf "Доступны следующие поезда:\n"
      trains.each_with_index {|train, index| puts "#{index + 1}.#{train.title}"}
      printf ">> "
      index = gets.chomp.to_i
      train = trains[index - 1]
    end
    system "clear"
    printf "Сколько вагонов Отцепить?: "
    value = gets.chomp.to_i
    value.times{ train.pin_on }
    system "clear"
  when 7
    if trains.size.zero?
      printf "Нет доступных поездов" 
      printf previous_menu
      printf ">> "
      next if gets.chomp.to_i.zero? 
    else
      printf "Доступны следующие поезда:\n"
      trains.each_with_index {|train, index| puts "#{index + 1}.#{train.title}"}
      printf ">> "
      index = gets.chomp.to_i
      train = trains[index - 1]
    end
    system "clear"
    while true do
      printf "#{train.title}\n"
      printf "Маршрут поезда: #{train.route.stations.map(&:name).join('-')}\n"
      printf "Текущая станция: #{train.station.name}\n"
      printf previous_menu
      printf ">> "
      next until gets.chomp.to_i.zero? 
      break
    end
  when 8
    printf "Список доступных станций:\n"
    stations.each_with_index {|station, index| puts "#{index + 1}.#{station.name}"}
    printf previous_menu
    printf ">> "
    index = gets.chomp.to_i
    next if index.zero? 
    station = stations[index - 1]
    station.show_all
    printf previous_menu
    printf ">> "
    next until gets.chomp.to_i.zero? 
    system "clear"
  end
  
end
