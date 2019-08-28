# frozen_string_literal: true

# main class for both human and AI
class Person
  attr_accessor :balance, :hand, :card, :points
  attr_reader :name, :player, :dealer, :deck

  def initialize(*)
    @balance = 100
    @hand = []
    @points = 0
  end

  def take_card(deck)
    @card = deck.take_card
    @hand << @card
    @points += @card.value
    ace_recount if limit?
  end

  def ace_recount
    @hand.each do |card|
      if limit? && card.ace?
        card.value = 1
        @points -= 10
      end
    end
  end

  def limit?
    @points > 21
  end
end
