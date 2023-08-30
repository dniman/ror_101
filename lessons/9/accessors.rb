# frozen_string_literal: true

# Accessors
module Accessors
  def self.included(klass)
    klass.extend ClassMethods
  end

  # Class methods
  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        def_attr_accessor(name)

        def_attr_accessor_history(name)
      end
    end

    def strong_attr_accessor(name, klass)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |val|
        raise TypeError, 'Error type of assigned value' unless val.is_a?(klass)

        instance_variable_set(var_name, val)
      end
      instance_variable_get(var_name)
    end

    private

    def def_attr_accessor(name)
      name_history = "#{name}_history".to_sym
      define_method(name) { send(name_history).last }
      define_method("#{name}=".to_sym) { |v| send(name_history) << v }
    end

    def def_attr_accessor_history(name)
      var_name = "@#{name}_history".to_sym
      define_method("#{name}_history".to_sym) do
        instance_variable_set(var_name, []) unless instance_variable_get(var_name)
        instance_variable_get(var_name)
      end
      instance_variable_get(var_name)
    end
  end
end
