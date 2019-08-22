class Person
  attr_accessor :balance, :hand
  attr_reader :name, :points, :player, :dealer, :deck

  def initialize(*)
    @balance = 100
    @hand = []
  end

  def take_card(deck)
    card = deck.take_card
    if limit?
      if card.face.to_s.include?('A')
        card.value = 1
      else
        ace_recount
      end
    end
    @hand << card
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

  def draw_hand
    puts "#{@name}'s hand: #{@points} points total"
    puts '*' * 30
    @hand.each_key do |card|
      print "|#{card}| "
    end
    puts
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
