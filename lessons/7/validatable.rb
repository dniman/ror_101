# frozen_string_literal: true

module Validatable
  private

  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
