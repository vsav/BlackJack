class Person
  attr_accessor :balance, :hand

  def initialize
    @balance = 100
    @hand = {}
  end

  def take_card(deck)
    card = deck.take_card
    @hand[card[0]] = card[1]
    if limit?
      if card[0].to_s.include?('A')
        @hand[card[0]] = 1
      else
        ace_recount
      end
    end
    draw_hand
    count_points
    #puts "Points total: #{@points}"
  end

  def count_points
    @points = 0
    @hand.each_value do |value|
      @points += value
    end
  end

  def pass
  end

  def ace_recount
    @hand.each do |card|
      @hand[card[0]] = 1 if card[0].to_s.include?('A')
    end
  end

  def draw_hand
    @hand.each_key do |card|
      print "|#{card}| "
    end
  end

  def limit?
    count_points
    @points >= 21
  end
end
