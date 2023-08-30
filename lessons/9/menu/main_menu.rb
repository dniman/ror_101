# frozen_string_literal: true

require_relative 'file_menu'
require_relative 'station_menu'
require_relative 'train_menu'
require_relative 'route_menu'

module Menu
  class MainMenu < FileMenu
    using Utils

    def method_missing(method_name, *args, &block)
      if method_name.to_s.end_with?('_action')
        klass(method_name).new.activate!
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      method_name.to_s.end_with?('_action') || super
    end

    private

    def klass(name)
      Object.const_get("Menu::#{klass_name(name)}")
    end

    def klass_name(name)
      name.to_s.gsub('action', 'menu').to_s.classify
    end
  end
end
