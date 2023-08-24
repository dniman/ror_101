module Validatable
  
  private

    def valid?
      validate!
      true
    rescue
      false
    end
end
