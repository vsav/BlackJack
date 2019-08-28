# frozen_string_literal: true

# AI player class
class Dealer < Person
  attr_accessor :hidden

  def initialize
    super
    @name = 'Dealer'
    @hidden = true
  end

  def next_turn(deck)
    take_card(deck) if another_card?
  end

  def another_card?
    if @points >= 21
      false
    elsif @points >= 17 && @points <= 21
      false
    else
      true
    end
  end
end
