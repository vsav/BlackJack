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
    faces = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8,
              '9' => 9, '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => 11 }
    suits = [Card::SPADES, Card::DIAMOND, Card::CLUB, Card::HEART]

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
