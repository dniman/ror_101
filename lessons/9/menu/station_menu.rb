# frozen_string_literal: true

require_relative 'file_menu'
require_relative 'actions/common_actions'
require_relative 'actions/station_actions'

module Menu
  class StationMenu < FileMenu
    include Actions::CommonActions
    include Actions::StationActions
  end
end
