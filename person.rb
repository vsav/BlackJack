class Person
  attr_accessor :balance, :hand

  def initialize
    @balance = 100
    @hand = {}
  end

  def take_card(deck)
    card = deck.take_card
    @hand[card[0]] = card[1]
    show_hand
    count_points
    check_victory?
  end

  def count_points
    @points = 0
    @hand.each_value do |value|
      @points += value
    end
    puts "Points total: #{@points}"
  end

  def pass
  end

  def show_hand
    @hand.each_key do |card|
      print "|#{card}| "
    end
  end

  def check_victory?
    if @points > 21
      #if @hand.keys.to_s.include?('A')
      #  a = @hand.select{ |key, value| value == 11 }
      #  @hand[a] = 1
      #  puts a
      #  draw_hand
      #  count_points
      #end
      puts "YOU DIED!"
      false
    else
      true
    end
  end
end
