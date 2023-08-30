# frozen_string_literal: true

require './station'
require_relative '../text_menu'

module Menu
  module Actions
    module StationActions
      def create_station_action
        begin
          print 'Введите наименование станции: '
          name = gets.chomp

          station = create_station(name)
        rescue RuntimeError => e
          puts e.message
          retry
        end

        puts "Добавлена новая станция #{station.name}"

        press_any_button_to_continue
      end

      def show_stations_action
        show_stations

        press_any_button_to_continue
      end

      def show_station_trains_action
        if stations.size.positive?
          station = self.station

          station.show_all
        else
          puts 'Список станций пуст'
        end

        press_any_button_to_continue
      end

      private

      def stations
        Station.all || []
      end

      def create_station(name)
        Station.new(name)
      end

      def station
        raw_menu = {
          'header' => 'Выберите станцию из списка: ',
          'actions' =>
            stations.each_with_object({}).with_index(1) do |(station, actions), index|
              action = lambda do |num|
                $memory_pool[:station] = stations[num - 1]
              end

              actions[action] = "  #{index}.#{station.name}"
            end,
          'footer' => '>> '
        }

        TextMenu.new(raw_menu).activate!

        $memory_pool[:station]
      end

      def show_stations
        arr = []
        if stations.size.positive?
          arr << 'Список станций: '
          stations.each do |station|
            arr << "  #{station.name}"
          end
        end
        arr << "Всего станций: #{stations.size}"

        puts arr.join("\n")
      end
    end
  end
end
