# frozen_string_literal: true

require 'yaml'
require_relative '../utils'
require_relative 'base_menu'

module Menu
  class FileMenu < BaseMenu
    using Utils
    
    def initialize
      super(self.load_menu)
    end

    def select_action(num)
      num.zero? ? actions[actions.size - 1] : actions[num - 1] if num <= actions.size
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
      begin
        YAML.load(self.read_yaml)
      rescue Psych::SyntaxError
        puts "Ошибка в структуре файла #{file_name}"

        exit
      end
    end

    def read_yaml
      File.read(self.file_name)
    rescue Exception => e
      puts "Ошибка при чтении файла #{file_name}"

      exit
    end

    def file_name
      File.expand_path("#{self.class.to_s.underscore}.yaml", Dir.pwd)
    end
  end
end
