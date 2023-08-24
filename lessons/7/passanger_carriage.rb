# frozen_string_literal: true

require_relative 'carriage'
require_relative 'validatable'

class PassangerCarriage < Carriage
  MAX_SEATS = 40

  attr_reader :type

  def initialize(seats_count)
    @type = "пассажирский"
    @seats = *(1..seats_count)
    @booked_seats = []
  end

  # забронировать место
  def book_a_seat(seat)
    self.check_a_seat!(seat)
    self.booked_seats << seat
    self.seats.delete(seat)
  end

  # кол-во занятых мест в вагоне
  def booked_seats_count
    self.booked_seats.length
  end

  # кол-во свободных мест в вагоне
  def seats_count
    seats.length
  end

  def info
    "#{self.type.capitalize} ваган №#{self.number}. Свободно - #{self.seats}, Занято - #{self.booked_seats}"
  end
    
  private
    attr_reader :booked_seats, :seats
    
    def number
      @number ||= self.class.instances.select do |instance| 
        instance.type == self.type
      end.size + 1
    end

    def check_a_seat!(seat)
      raise "Извините, место #{seat} уже занято." if self.booked_seats.include?(seat)
      raise "Место #{seat} не существует." unless (self.booked_seats.include?(seat) || self.seats.include?(seat))
    end

    def validate!
      raise "Общее количество мест не может быть пустым!" if self.capacity.nil?
      raise "Общее количество мест не может быть больше #{MAX_SEATS}!" if self.capacity > MAX_SEATS
    end
end
