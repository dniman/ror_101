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

        section = self.section
        action = select_action(section)
        unless action.nil?
          action.call(section)
          self.active = false
        end
      end
    end
  end
end
