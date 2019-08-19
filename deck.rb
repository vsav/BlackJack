# \u{2660} - spades
# \u{2665} - heart
# \u{2666} - diamond
# \u{2663} - club
class Deck
  attr_reader :deck
  def initialize
    @deck = []
    combine_deck
    deck_shuffle
  end

  def combine_deck
    cards = {}
    faces = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8,
              '9' => 9, '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => 11 }
    suits = ["\u2660", "\u2665", "\u2666", "\u2663"]

    suits.each do |suit|
      faces.each do |face, value|
        face += suit
        cards[face] = value
      end
    end

    cards.each do |card|
      @deck << card
    end
  end

  def deck_shuffle
    @deck.shuffle!
  end

  def take_card
    @deck.slice!(-1)
  end
end
