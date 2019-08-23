# frozen_string_literal: true

# playing cards deck class
class Deck
  attr_reader :cards
  def initialize
    @cards = []
    collect_deck
    deck_shuffle
  end

  def collect_deck
    faces = Card::FACES
    suits = Card::SUITS

    suits.each do |suit|
      faces.each do |face, value|
        face += suit
        @cards << Card.new(face, value)
      end
    end
  end

  def deck_shuffle
    @cards.shuffle!
  end

  def take_card
    @cards.slice!(-1)
  end
end
