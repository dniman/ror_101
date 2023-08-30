# frozen_string_literal: true

module Menu
  module Actions
    module CommonActions
      def press_any_button_to_continue
        puts
        print 'Нажмите любую клавишу для продолжения...'
        gets
      end
    end
  end
end
