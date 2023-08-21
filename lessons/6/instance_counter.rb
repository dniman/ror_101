module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def new(*_, &block)
      instance = super
      self.register_instance(instance)
      instance
    end

    def instances
      @instances
    end

    private
    def register_instance(instance)
      @instances ||= []
      @instances << instance
    end
  end
  
  def inherited(subclass)
    instances = "@#{instances}"
    subclass.instance_variable_set(instances, instance_variable_get(instances))
  end
end
