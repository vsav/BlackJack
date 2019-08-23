# frozen_string_literal: true

# main class for both human and AI
class Person
  attr_accessor :balance, :hand, :card
  attr_reader :name, :points, :player, :dealer, :deck

  def initialize(*)
    @balance = 100
    @hand = []
  end

  def take_card(deck)
    @card = deck.take_card
    @hand << card
    if limit?
      if @card.face.to_s.include?('A')
        @card.value = 1
      else
        ace_recount
      end
    end
    count_points
  end

  def count_points
    @points = 0
    @hand.each do |card|
      @points += card.value
    end
  end

  def ace_recount
    @hand.each do |card|
      card.value = 1 if card.face.to_s.include?('A')
    end
  end

  def limit?
    count_points
    @points > 21
  end
end
