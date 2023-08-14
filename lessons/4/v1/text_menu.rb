# frozen_string_literal: true

class TextMenu
  def initialize(text)
    @text = text
  end

  def show
    print @text
    print '>> '

    gets.chomp.to_i
  end

  def clear
    system 'clear'
  end
end
