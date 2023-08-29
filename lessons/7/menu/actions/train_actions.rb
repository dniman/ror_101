# frozen_string_literal: true

require_relative '../text_menu'
require './passanger_train'
require './cargo_train'
require './cargo_carriage'
require './passanger_carriage'

module Menu
  module Actions
    module TrainActions
      PASSANGER_TRAIN = 1
      CARGO_TRAIN = 2

      def create_train_action
        begin
          print 'Введите номер поезда: '
          number = gets.chomp
          print 'Введите тип поезда(1-пассажирский, 2-грузовой): '
          type = gets.chomp.to_i

          train = create_train(number, type)
        rescue RuntimeError => e
          puts e.message
          retry
        end

        puts "Добавлен новый #{train.title}"

        press_any_button_to_continue
      end

      def show_trains_action
        show_trains

        press_any_button_to_continue
      end

      def pin_on_carriage_action
        if trains.size.positive?
          train = self.train

          pin_on_carriage(train)
          puts "Прицеплен новый вагон к #{train.title}"
        else
          puts 'Список поездов пуст'
        end

        press_any_button_to_continue
      end

      def pin_off_carriage_action
        if trains.size.positive?
          train = self.train

          train.pin_off(train.carriages.last)
          puts "Отцеплен вагон от #{train.title}"
        else
          puts 'Список поездов пуст'
        end

        press_any_button_to_continue
      end

      def attach_route_action
        if trains.size.positive?
          train = self.train

          if routes.size.positive?
            train.route = route
          else
            puts 'Список маршрутов пуст'
          end
        else
          puts 'Список поездов пуст'
        end

        press_any_button_to_continue
      end

      def move_next_station_action
        if trains.size.positive?
          train = self.train

          train.move_next_station
          puts "Поезд перемещен на станцию #{train.station.name}"
        else
          puts 'Список поездов пуст'
        end

        press_any_button_to_continue
      end

      def move_previous_station_action
        if trains.size.positive?
          train = self.train

          train.move_previous_station
          puts "Поезд перемещен на станцию #{train.station.name}"
        else
          puts 'Список поездов пуст'
        end

        press_any_button_to_continue
      end

      def show_train_carriages_action
        if trains.size.positive?
          train = self.train

          train.each_carriage do |carriage|
            puts carriage.info
          end
        else
          puts 'Список поездов пуст'
        end

        press_any_button_to_continue
      end

      def reserve_space_action
        if trains.size.positive?
          train = self.train

          if train.carriages.size.positive?
            carriage = self.carriage(train)

            reserve_space(carriage)
          else
            puts 'Список вагонов поезда пуст'
          end
        else
          puts 'Список поездов пуст'
        end

        press_any_button_to_continue
      end

      private

      def trains
        (CargoTrain.instances.nil? ? [] : CargoTrain.instances) + \
          (PassangerTrain.instances.nil? ? [] : PassangerTrain.instances)
      end

      def routes
        Route.instances
      end

      def create_train(number, type)
        case type
        when PASSANGER_TRAIN
          PassangerTrain.new(number)
        when CARGO_TRAIN
          CargoTrain.new(number)
        else
          raise 'Поезда с таким типом не существует!'
        end
      end

      def train
        raw_menu = {
          'header' => 'Выберите поезд из списка: ',
          'actions' =>
            trains.each_with_object({}).with_index(1) do |(_train, actions), index|
              action = lambda do |num|
                $memory_pool[:train] = trains[num - 1]
              end

              actions[action] = "  #{index}.#{trains[index - 1].title}"
            end,
          'footer' => '>> '
        }

        TextMenu.new(raw_menu).activate!

        $memory_pool[:train]
      end

      def route
        raw_menu = {
          'header' => 'Выберите маршрут из списка: ',
          'actions' =>
            routes.each_with_object({}).with_index(1) do |(route, actions), index|
              action = lambda do |num|
                $memory_pool[:route] = routes[num - 1]
              end

              actions[action] = "  #{index}.#{route.stations.map(&:name).join('-')}"
            end,
          'footer' => '>> '
        }

        TextMenu.new(raw_menu).activate!

        $memory_pool[:route]
      end

      def carriage(train)
        raw_menu = {
          'header' => 'Выберите вагон из списка: ',
          'actions' =>
            train.carriages.each_with_object({}).with_index(1) do |(_carriage, actions), index|
              action = lambda do |num|
                $memory_pool[:carriage] = train.carriages[num - 1]
              end

              actions[action] = "  #{index}.#{train.carriages[index - 1].info}"
            end,
          'footer' => '>> '
        }

        TextMenu.new(raw_menu).activate!

        $memory_pool[:carriage]
      end

      def show_trains
        arr = []
        if trains.size.positive?
          arr << 'Список поездов: '
          trains.each do |train|
            arr << "  #{train.title}"
          end
        end
        arr << "Всего поездов: #{trains.size}"

        puts arr.join("\n")
      end

      def show_routes
        arr = []
        if routes.size.positive?
          arr << 'Список маршрутов: '
          routes.each do |route|
            arr << "  #{route.stations.map(&:name).join('-')}"
          end
          arr << "Всего маршрутов: #{routes.size}"
        end

        puts arr.join("\n")
      end

      def pin_on_carriage(train)
        if train.type == 'пассажирский'
          train.pin_on(PassangerCarriage.new)
        else
          train.pin_on(CargoCarriage.new)
        end
      end

      def reserve_space(carriage)
        if carriage.type == 'пассажирский'
          carriage.occupy_space

          puts 'Зарезезервировано 1 место'
        else
          begin
            print 'Укажите занимаемый объем: '
            space = gets.chomp.to_i

            carriage.occupy_space(space)
            puts "Зарезезервирован объем #{space}"
          rescue StandardError => e
            puts e.message
            retry
          end
        end
      end
    end
  end
end
