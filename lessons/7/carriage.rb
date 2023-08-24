# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validatable'

class Carriage
  include InstanceCounter
  include Validatable
end
