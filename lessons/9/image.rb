# frozen_string_literal: true

class Image
  attr_reader :image

  def initialize(name)
    @image = load_image(name)
  end

  def show
    puts image
  end

  private

  def load_image(file_name)
    File.read(File.expand_path(file_name, Dir.pwd))
  rescue Errno::ENOENT
    puts "Файл не найден #{file_name}"

    exit
  end
end
