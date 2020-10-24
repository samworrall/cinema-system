# frozen_string_literal: true

require 'booking_parser'

RSpec.describe BookingParser do
  let(:subject) { BookingParser.new(bookings_file_path) }
  let(:bookings_file_path) { './spec/support/sample_booking_requests' }

  describe '#call' do
    it 'returns an array of parsed objects' do
      parsed_booking_requests = subject.call

      expect(parsed_booking_requests).to be_a(Array)
      expect(parsed_booking_requests.first).to eq(
        {
          id: 0,
          first_seat_row: 47,
          first_seat: 39,
          last_seat_row: 47,
          last_seat: 41
        }
      )
    end
  end
end
