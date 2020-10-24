# frozen_string_literal: true

# BookingParser responsible for parsing a text file of booking requests into a usable format.
class BookingParser
  def initialize(file_path)
    @file_path = file_path
  end

  attr_reader :file_path

  def call
    parsed_bookings = []

    File.open(file_path) do |file|
      file.readlines.each do |line|
        formatted_line = line.tr('()', '').tr(':', ',').split(',')
        parsed_bookings << {
          id: formatted_line[0].to_i,
          first_seat_row: formatted_line[1].to_i,
          first_seat: formatted_line[2].to_i,
          last_seat_row: formatted_line[3].to_i,
          last_seat: formatted_line[4].to_i
        }
      end
    end

    parsed_bookings
  end
end
