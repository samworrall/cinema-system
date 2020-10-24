# frozen_string_literal: true

require 'process_booking_requests'

RSpec.describe ProcessBookingRequests do
  let(:subject) { described_class }
  let(:bookings_file_path) { './spec/support/sample_booking_requests' }

  describe '#call' do
    it 'returns a list of rejected bookings' do
      expect(subject.call(bookings_file_path).length).to eq(10)
    end
  end
end
