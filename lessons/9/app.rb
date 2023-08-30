require_relative 'menu'
require_relative 'accessors'
require_relative 'image'

class App
  include Accessors

  attr_accessor_with_history :images
  strong_attr_accessor :image, Image

  attr_reader :menu

  def initialize
    %w[choochoo1.txt choochoo2.txt choochoo3.txt].each do |image|
      self.images = Image.new(image)
    end

    # Принудительно ставим первую картинку
    self.image = images_history.first

    @menu = Menu::MainMenu.new
  end

  def run
    5.downto(1) do |time|
      system('clear')
      image.show

      print time
      sleep 1
    end
    menu.activate!
  end

  private

  def load_menu
    File.read(file_name)
  rescue Errno::ENOENT
    puts "Файл не найден #{file_name}"

    exit
  end

  def file_name
    File.expand_path('choochoo1.txt', Dir.pwd)
  end
end
