# frozen_string_literal: true

require 'yaml'
require_relative '../utils'
require_relative 'base_menu'

module Menu
  class FileMenu < BaseMenu
    using Utils

    def initialize
      super(load_menu)
    end

    def select_action(num)
      return unless num <= actions.size

      num.zero? ? actions[actions.size - 1] : actions[num - 1]
    end

    def activate!
      self.active = true

      while active?
        clear_screen
        show

        action = select_action(section)
        send(action) unless action.nil?

        clear_screen
      end
    end

    private

    def load_menu
      YAML.load(read_yaml)
    rescue Psych::SyntaxError
      puts "Ошибка в структуре файла #{file_name}"

      exit
    end

    def read_yaml
      File.read(file_name)
    rescue Errno::ENOENT
      puts "Файл не найден #{file_name}"

      exit
    end

    def file_name
      File.expand_path("#{self.class.to_s.underscore}.yaml", Dir.pwd)
    end
  end
end
