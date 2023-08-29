# frozen_string_literal: true

require_relative 'menu'

$memory_pool = {}

menu = Menu::MainMenu.new
menu.activate!
