require_relative 'station'
require_relative 'cargo_train'
require_relative 'passanger_train'
require_relative 'route'
require_relative 'main_menu'

$stations = []
$trains = []
$routes = []

@main_menu = MainMenu.new.tap do |m|
  m.header = "Выберите раздел из списка: "
  m.sections << "  1. Раздел станции"
  m.sections << "  2. Раздел поезда"
  m.sections << "  3. Раздел маршруты"
  m.sections << "  0. Выйти"
  m.footer = ">> "
  m.actions << :station_action
  m.actions << :train_action
  m.actions << :route_action
end

@main_menu.activate!
