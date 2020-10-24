# frozen_string_literal: true

# BookingValidator responsible for assessing the valididty of the booking request.
class BookingValidator
  def self.is_valid_booking?(booking, theatre)
    seats_are_on_same_row?(booking) &&
    no_more_than_5_seats?(booking) &&
    all_seats_available?(booking, theatre) &&
    booking_does_not_leave_one_seat_gap?(booking, theatre)
  end

  private

  def self.seats_are_on_same_row?(booking)
    booking[:first_seat_row] == booking[:last_seat_row]
  end

  def self.no_more_than_5_seats?(booking)
    (booking[:last_seat] - booking[:first_seat]) <= 5
  end

  def self.all_seats_available?(booking, theatre)
    row = booking[:first_seat_row]
    first_seat = booking[:first_seat]
    num_of_seats = booking[:last_seat] - booking[:first_seat]

    seats = theatre[row].slice(first_seat, num_of_seats)
    !seats.any?('X')
  end

  def self.booking_does_not_leave_one_seat_gap?(booking, theatre)
    !gap_on_left_of_booking?(booking, theatre) && !gap_on_right_of_booking?(booking, theatre)
  end

  def self.gap_on_left_of_booking?(booking, theatre)
    row = booking[:first_seat_row]
    first_seat = booking[:first_seat]

    return false if first_seat == 0

    if first_seat == 1
      return false unless theatre[row][0] == nil
    elsif theatre[row][first_seat - 1] == 'X'
      return false
    elsif theatre[row][first_seat - 2] == nil
      return false
    end

    return true
  end

  def self.gap_on_right_of_booking?(booking, theatre)
    row = booking[:first_seat_row]
    last_seat = booking[:last_seat]

    return false if last_seat == 49

    if last_seat == 48
      return false unless theatre[row][49] == nil
    elsif theatre[row][last_seat + 1] == 'X'
      return false
    elsif theatre[row][last_seat + 2] == nil
      return false
    end

    return true
  end
end
