class Person
  attr_accessor :balance, :hand
  attr_reader :name, :points

  def initialize(*)
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
    count_points
  end

  def count_points
    @points = 0
    @hand.each_value do |value|
      @points += value
    end
  end

  def place_bet
    @balance -= 10
  end

  def ace_recount
    @hand.each do |card|
      @hand[card[0]] = 1 if card[0].to_s.include?('A')
    end
  end

  def draw_hand
    puts "#{@name}'s hand: #{@points} points total"
    puts '*' * 30
    @hand.each_key do |card|
      print "|#{card}| "
    end
    puts
  end

  def make_turn
    take_card(@deck) if another_card?
  end

  def limit?
    count_points
    @points > 21
  end

  def another_card?
    begin
      print 'One more card?(1:take card, 2:pass): '
      user_input = gets.to_i
      raise 'Please input 1 to take card or 2 to pass' unless [1, 2].include?(user_input)
    rescue RuntimeError => e
      puts e.message
      retry
    end
    return true if user_input == 1
  end
end
