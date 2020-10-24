# frozen_string_literal: true

require 'booking_validator'

RSpec.describe BookingValidator do
  let(:subject) { described_class }
  let(:theatre) { Array.new(100) { Array.new(50) } }

  describe '#valid_booking?' do
    context 'when the booking occupies more than one row' do
      let(:booking) { { id: 0, first_seat_row: 2, first_seat: 0, last_seat_row: 3, last_seat: 2 } }

      it 'returns false' do
        expect(subject.valid_booking?(booking, theatre)).to eq(false)
      end
    end

    context 'when the booking occupies more than 5 seats' do
      let(:booking) { { id: 1, first_seat_row: 2, first_seat: 0, last_seat_row: 2, last_seat: 6 } }

      it 'returns false' do
        expect(subject.valid_booking?(booking, theatre)).to eq(false)
      end
    end

    context 'when the booking contains a seat that is already booked' do
      before do
        theatre[2][0] = 'X'
      end

      let(:booking) { { id: 2, first_seat_row: 2, first_seat: 0, last_seat_row: 2, last_seat: 2 } }

      it 'returns false' do
        expect(subject.valid_booking?(booking, theatre)).to eq(false)
      end
    end

    context 'when accepting the booking would leave a single seat gap' do
      context 'when leaving a gap on the left' do
        let(:booking) { { id: 3, first_seat_row: 2, first_seat: 1, last_seat_row: 2, last_seat: 3 } }

        it 'returns false' do
          expect(subject.valid_booking?(booking, theatre)).to eq(false)
        end
      end

      context 'when leaving a gap on the right' do
        before do
          theatre[2][9] = 'X'
        end

        let(:booking) { { id: 4, first_seat_row: 2, first_seat: 5, last_seat_row: 2, last_seat: 7 } }

        it 'returns false' do
          expect(subject.valid_booking?(booking, theatre)).to eq(false)
        end
      end
    end

    context 'when the booking passes all validations' do
      let(:booking) { { id: 5, first_seat_row: 2, first_seat: 0, last_seat_row: 2, last_seat: 2 } }

      it 'returns true' do
        expect(subject.valid_booking?(booking, theatre)).to eq(true)
      end
    end
  end
end
