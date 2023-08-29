# frozen_string_literal: true

require_relative 'file_menu'
require_relative 'actions/common_actions'
require_relative 'actions/route_actions'

module Menu
  class RouteMenu < FileMenu
    include Actions::RouteActions
    include Actions::CommonActions
  end
end
