# frozen_string_literal: true

require_relative 'file_menu'
require_relative 'actions/common_actions'
require_relative 'actions/train_actions'

module Menu
  class TrainMenu < FileMenu
    include Actions::CommonActions
    include Actions::TrainActions
  end
end
