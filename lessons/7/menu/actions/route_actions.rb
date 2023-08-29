require './route'
require_relative '../text_menu'

module Menu
  module Actions
    module RouteActions

      def create_route_action
        begin
          if stations.size >= 1
            route = create_route(initial_station, final_station)

            puts "Добавлен новый маршрут #{route.stations.map(&:name).join('-')}"
          else
            puts 'Недостаточно станций для создания маршрута'
          end
        rescue StandardError => e
          puts e.message
          retry
        end

        press_any_button_to_continue
      end

      def show_routes_action
        show_routes

        press_any_button_to_continue
      end

      def add_station_action
        if routes.size.positive?
          route = self.route

          if available_stations(route).size.positive?
            station = self.station(route)

            puts "Добавлен новая станция #{station.name} к маршруту #{route.stations.map(&:name).join('-')}"
            route.add(station)
          else
            puts "Нет доступных станция для добавления к данному маршруту"
          end
        else
          puts "Список маршрутов пуст"
        end

        press_any_button_to_continue
      end

      def delete_station_action
        if routes.size.positive?
          route = self.route
          if route.intermediate_stations.size.positive?
            station = self.intermediate_station(route)

            puts "Удалена станция #{station.name} из маршрута #{route.stations.map(&:name).join('-')}"
            route.delete(station)
          else
            puts "Нет прометуточных станций у данного маршрута"
          end
        else
          puts "Отсутствуют маршруты"
        end

        press_any_button_to_continue
      end

      private

      def stations
        Station.all || []
      end

      def routes
        Route.instances || []
      end

      def create_route(initial_station, final_station)
        Route.new(initial_station, final_station)
      end
      
      def initial_station
        raw_menu = {
          "header" => "Выберите начальную станцию из списка: ",
          "actions" => 
            stations.each_with_object({}).with_index(1) do |(station,actions), index|
              action = ->(num) do 
                $memory_pool[:initial_station] = stations[num - 1]
              end

              actions[action] = "  #{index}.#{station.name}"
            end,
          "footer" => ">> "
        }

        TextMenu.new(raw_menu).activate!
        
        $memory_pool[:initial_station]
      end

      def final_station
        available_stations = stations - [$memory_pool[:initial_station]]

        raw_menu = {
          "header" => "Выберите конечную станцию из списка: ",
          "actions" => 
            available_stations.each_with_object({}).with_index(1) do |(station,actions), index|
              action = ->(num) do
                $memory_pool[:final_station] = available_stations[num - 1]
              end
          
              actions[action] = "  #{index}.#{station.name}"
            end,
          "footer" => ">> "
        }
        
        TextMenu.new(raw_menu).activate!

        $memory_pool[:final_station]
      end

      def route
        raw_menu = {
          "header" => "Выберите маршрут из списка: ",
          "actions" => 
            routes.each_with_object({}).with_index(1) do |(route,actions), index|
              action = ->(num) do
                $memory_pool[:route] = routes[num - 1]
              end
          
              actions[action] = "  #{index}.#{route.stations.map(&:name).join('-')}"
            end,
          "footer" => ">> "
        }
        
        TextMenu.new(raw_menu).activate!

        $memory_pool[:route]
      end
      
      def available_stations(route)
        available_stations = stations - route.stations
      end
      
      def station(route)
        raw_menu = {
          "header" => "Выберите промежуточную станцию из списка: ",
          "actions" => 
            available_stations(route).each_with_object({}).with_index(1) do |(station,actions), index|
              action = ->(num) do
                $memory_pool[:station] = available_stations(route)[num - 1]
              end
          
              actions[action] = "  #{index}.#{available_stations(route)[index - 1].name}"
            end,
          "footer" => ">> "
        }
        
        TextMenu.new(raw_menu).activate!

        $memory_pool[:station]
      end

      def intermediate_station(route)
        raw_menu = {
          "header" => "Выберите промежуточную станцию из списка: ",
          "actions" => 
            route.intermediate_stations.each_with_object({}).with_index(1) do |(station,actions), index|
              action = ->(num) do
                $memory_pool[:intermediate_station] = route.intermediate_stations[num - 1]
              end
          
              actions[action] = "  #{index}.#{route.intermediate_stations[index - 1].name}"
            end,
          "footer" => ">> "
        }
        
        TextMenu.new(raw_menu).activate!

        $memory_pool[:intermediate_station]
      end

      def show_routes
        arr = []
        if routes.size.positive?
          arr << "Список маршрутов: "  
          routes.each do |route|
            arr << "  #{route.stations.map(&:name).join('-')}"
          end
        end
        arr << "Всего маршрутов: #{routes.size}"
        puts arr.join("\n")
      end

    end
  end
end
