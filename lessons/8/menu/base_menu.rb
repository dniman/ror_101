# frozen_string_literal: true

module Menu
  class BaseMenu
    attr_reader :sections, :section_num, :actions, :header, :footer

    def initialize(raw_menu)
      @raw_menu = raw_menu
      @header = @raw_menu['header']
      @sections = @raw_menu['actions'].values
      @actions = @raw_menu['actions'].keys(&:to_sym)
      @footer = @raw_menu['footer']

      self.active = false
    end

    def section
      gets.chomp.to_i
    end

    def show
      print info
    end

    def select_action(_num)
      raise 'not implemented'
    end

    def clear_screen
      system 'clear'
    end

    def info
      [header, sections, footer].flatten.join("\n")
    end

    def activate!
      raise 'not implemented'
    end

    def exit_action
      self.active = false
    end

    private

    attr_writer :active

    def active?
      @active
    end
  end
end
