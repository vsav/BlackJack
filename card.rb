# frozen_string_literal: true

# playing card class
class Card
  attr_reader :face
  attr_accessor :value

  SPADES = "\u2660"
  HEART = "\u2665"
  DIAMOND = "\u2666"
  CLUB = "\u2663"

  SUITS = [SPADES, HEART, DIAMOND, CLUB].freeze
  FACES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8,
            '9' => 9, '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => 11 }.freeze

  def initialize(face, value, suit)
    @face = face
    @value = value
    @suit = suit
  end

  def ace?
    @face.to_s.include?('A')
  end

  def card_face
    @face + @suit
  end
end
