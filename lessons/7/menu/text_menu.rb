# frozen_string_literal: true

require_relative 'base_menu'

module Menu
  class TextMenu < BaseMenu
    def select_action(num)
      actions[num - 1] if num.positive? && num <= actions.size
    end

    def activate!
      self.active = true

      while active?
        clear_screen
        show

        self.active = false if call_action(section)
      end
    end

    private

    def call_action(section)
      action = select_action(section)

      action&.call(section)
    end
  end
end
