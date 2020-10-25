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
      let(:booking) { { id: 1, first_seat_row: 2, first_seat: 0, last_seat_row: 2, last_seat: 5 } }

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

    describe 'checking for a single seat gap' do
      context 'when the first seat is at the start of the row' do
        let(:booking) { { id: 3, first_seat_row: 2, first_seat: 0, last_seat_row: 2, last_seat: 1 } }

        it 'returns true' do
          expect(subject.valid_booking?(booking, theatre)).to eq(true)
        end
      end

      context 'when leaving a gap on the left and first seat is index 1' do
        let(:booking) { { id: 4, first_seat_row: 2, first_seat: 1, last_seat_row: 2, last_seat: 2 } }

        it 'returns false' do
          expect(subject.valid_booking?(booking, theatre)).to eq(false)
        end
      end

      context 'when the seats are somewhere in the middle of the row and do not leave a gap' do
        let(:booking) { { id: 5, first_seat_row: 2, first_seat: 40, last_seat_row: 2, last_seat: 41 } }

        it 'returns true' do
          expect(subject.valid_booking?(booking, theatre)).to eq(true)
        end
      end

      context 'when the seats are somewhere in the middle of the row and leave a gap on the left' do
        before do
          theatre[2][38] = 'X'
        end
        let(:booking) { { id: 6, first_seat_row: 2, first_seat: 40, last_seat_row: 2, last_seat: 41 } }

        it 'returns false' do
          expect(subject.valid_booking?(booking, theatre)).to eq(false)
        end
      end

      context 'when the seats are somewhere in the middle of the row and leave a gap on the right' do
        before do
          theatre[2][38] = 'X'
        end
        let(:booking) { { id: 7, first_seat_row: 2, first_seat: 35, last_seat_row: 2, last_seat: 36 } }

        it 'returns false' do
          expect(subject.valid_booking?(booking, theatre)).to eq(false)
        end
      end

      context 'when the last seat is at the end of the row' do
        let(:booking) { { id: 8, first_seat_row: 2, first_seat: 48, last_seat_row: 2, last_seat: 49 } }

        it 'returns true' do
          expect(subject.valid_booking?(booking, theatre)).to eq(true)
        end
      end

      context 'when leaving a gap on the right and last seat is index 48' do
        let(:booking) { { id: 9, first_seat_row: 2, first_seat: 47, last_seat_row: 2, last_seat: 48 } }

        it 'returns false' do
          expect(subject.valid_booking?(booking, theatre)).to eq(false)
        end
      end
    end

    context 'when the booking passes all validations' do
      let(:booking) { { id: 10, first_seat_row: 2, first_seat: 0, last_seat_row: 2, last_seat: 2 } }

      it 'returns true' do
        expect(subject.valid_booking?(booking, theatre)).to eq(true)
      end
    end
  end
end
