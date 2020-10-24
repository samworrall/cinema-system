# frozen_string_literal: true

# CinemaSystem responsible for holding the state of the theatre
class CinemaSystem
  def initialize
    @theatre = Array.new(100) { Array.new(50) }
  end

  attr_accessor :theatre

  def update_theatre(row:, first_seat:, last_seat:)
    (first_seat..last_seat).each do |seat|
      theatre[row][seat] = 'X'
    end
  end
end
