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
    Card::SUITS.each do |suit|
      Card::FACES.each do |face, value|
        @cards << Card.new(face, value, suit)
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
