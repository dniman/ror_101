class TextMenu
  attr_accessor :header, :footer
  attr_reader :sections, :section_num, :actions
  
  def initialize
    @sections = []
    @actions = []
    self.active = false
  end

  def get_section
    gets.chomp.to_i
  end

  def show
    print info
  end  

  def select_action(num)
    num.zero? ? actions[actions.size - 1] : actions[num - 1]
  end

  def clear_screen
    system "clear"
  end

  def info
    [header, sections, footer].flatten.join("\n")
  end

  def activate!
    self.active = true

    while self.active? do
      clear_screen
      show
      section = get_section
      
      if section.zero?
        self.active = false
      else
        send(select_action(section))
      end 

      clear_screen
    end 
  end

  private
  attr_writer :active

  def active?
    @active
  end
end
