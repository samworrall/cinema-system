# frozen_string_literal: true

require_relative './cinema_system'
require_relative './booking_parser'
require_relative './booking_validator'

# ProcessBookingRequests responsible for taking a text file of booking requests and returning the rejected ones
class ProcessBookingRequests
  def self.call(file_path)
    cinema_system = CinemaSystem.new
    booking_requests = BookingParser.new(file_path).call

    invalid_booking_requests = []

    booking_requests.each do |booking_request|
      if BookingValidator.valid_booking?(booking_request, cinema_system.theatre)
        cinema_system.update_theatre(booking_request)
      else
        invalid_booking_requests << booking_request
      end
    end

    invalid_booking_requests
  end
end
