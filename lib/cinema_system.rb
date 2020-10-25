# frozen_string_literal: true

# CinemaSystem responsible for holding the state of the theatre
class CinemaSystem
  def initialize
    @theatre = Array.new(100) { Array.new(50) }
  end

  attr_accessor :theatre

  def book_seats(booking_request)
    row = booking_request[:first_seat_row]
    first_seat = booking_request[:first_seat]
    last_seat = booking_request[:last_seat]

    (first_seat..last_seat).each do |seat|
      theatre[row][seat] = 'X'
    end
  end
end
