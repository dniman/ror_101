# frozen_string_literal: true
require_relative 'text_menu'

class Routine
  def initialize(text = nil)
    @menu = TextMenu.new(text)

    @active = false
    @subroutines = []
  end

  def register(subroutine)
    @subroutines << subroutine
  end

  def run
    self.active = true

    while active?
      @menu.clear
      number = @menu.show

      case number
      when 0
        self.active = false
      else
        subroutine = @subroutines[number - 1]
        next if subroutine.nil?

        subroutine.run
      end
    end

    @menu.clear
  end

  private

  attr_writer :active

  def active?
    @active
  end
end
