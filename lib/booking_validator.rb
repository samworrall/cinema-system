# frozen_string_literal: true

END_OF_ROW = 49

# BookingValidator responsible for assessing the valididty of the booking request.
class BookingValidator
  def self.valid_booking?(booking, theatre)
    seats_are_on_same_row?(booking) &&
      no_more_than_5_seats?(booking) &&
      all_seats_available?(booking, theatre) &&
      booking_does_not_leave_one_seat_gap?(booking, theatre)
  end

  def self.seats_are_on_same_row?(booking)
    booking[:first_seat_row] == booking[:last_seat_row]
  end

  def self.no_more_than_5_seats?(booking)
    (booking[:last_seat] - booking[:first_seat]) < 5
  end

  def self.all_seats_available?(booking, theatre)
    row = booking[:first_seat_row]
    first_seat = booking[:first_seat]
    num_of_seats = (booking[:last_seat] - booking[:first_seat]) + 1

    seats = theatre[row].slice(first_seat, num_of_seats)

    seats.none?('X')
  end

  def self.booking_does_not_leave_one_seat_gap?(booking, theatre)
    !gap_on_left_of_booking?(booking, theatre) && !gap_on_right_of_booking?(booking, theatre)
  end

  def self.gap_on_left_of_booking?(booking, theatre)
    row = booking[:first_seat_row]
    first_seat = booking[:first_seat]

    return false if first_seat.zero?

    if first_seat == 1
      return false unless theatre[row][0].nil?
    elsif theatre[row][first_seat - 1] == 'X'
      return false
    elsif theatre[row][first_seat - 2].nil?
      return false
    end

    true
  end

  def self.gap_on_right_of_booking?(booking, theatre)
    row = booking[:first_seat_row]
    last_seat = booking[:last_seat]

    return false if last_seat == END_OF_ROW

    if last_seat == (END_OF_ROW - 1)
      return false unless theatre[row][END_OF_ROW].nil?
    elsif theatre[row][last_seat + 1] == 'X'
      return false
    elsif theatre[row][last_seat + 2].nil?
      return false
    end

    true
  end

  private_class_method :seats_are_on_same_row?, :no_more_than_5_seats?, :all_seats_available?,
                       :booking_does_not_leave_one_seat_gap?, :gap_on_left_of_booking?,
                       :gap_on_right_of_booking?
end
