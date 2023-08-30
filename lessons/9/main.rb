# frozen_string_literal: true

require_relative 'app'

$memory_pool = {}

app = App.new
# Принудительно ставим вторую картинку
app.image = app.images_history[1]
app.run
