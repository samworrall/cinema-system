# frozen_string_literal: true

require 'cinema_system'

RSpec.describe CinemaSystem do
  let(:subject) { CinemaSystem.new }
  let(:booking_request) { { id: 0, first_seat_row: 1, first_seat: 0, last_seat_row: 1, last_seat: 2 } }

  describe '#theatre' do
    it 'returns an array of arrays representing the 100 rows of 50 seats' do
      expect(subject.theatre).to be_a(Array)
      expect(subject.theatre.length).to eq(100)
      expect(subject.theatre.first.length).to eq(50)
    end
  end

  describe '#update_theatre' do
    it 'updates the theatre state, reserving seats' do
      subject.update_theatre(booking_request)
      expect(subject.theatre[1].slice(0, 3).all?('X')).to eq(true)
    end
  end
end
