# frozen_string_literal: true
require_relative 'routine'

class Subroutine0101 < Routine
  def run
    print 'Введите наименование станции: '
    station = gets.chomp

    App.create_station(station)
  end
end
