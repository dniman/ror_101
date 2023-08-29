# frozen_string_literal: true

module Manufacturerable
  attr_reader :manufacturer

  def manufacturer=(value)
    @manufacturer = value
  end
end
