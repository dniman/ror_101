# frozen_string_literal: true

module Validation
  def self.included(klass)
    klass.include InstanceMethods
    klass.extend ClassMethods
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        attr = instance_variable_get("@#{validation[:attr_name]}".to_sym)
        send("validate_#{validation[:validation_type]}", attr, validation[:args])
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate_presence(attr, _args)
      raise 'Значение не может быть пустым!' if attr.nil? || (attr.is_a?(String) && attr.empty?)
    end

    def validate_format(attr, args)
      raise 'Значение не соответствует формату!' unless attr =~ args[0]
    end

    def validate_type(attr, args)
      raise 'Тип значения не соответствует заданному классу!' unless attr.is_a?(args[0])
    end

    def validate_max(attr, args)
      raise "Значение не может быть больше #{args[0]} символов!" if attr.length > args[0]
    end
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, *args)
      @validations ||= []
      @validations << { attr_name: name, validation_type: type, args: }
    end
  end
end
