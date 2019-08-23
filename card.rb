# frozen_string_literal: true

# playing card class
class Card
  attr_reader :face
  attr_accessor :value

  SPADES = "\u2660"
  HEART = "\u2665"
  DIAMOND = "\u2666"
  CLUB = "\u2663"

  def initialize(face, value)
    @face = face
    @value = value
  end
end
