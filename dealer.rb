class Dealer < Person
  def initialize
    super
    @name = 'Dealer'
  end

  def another_card?
    count_points
    if @points >= 21
      false
    elsif @points >= 17 && @points <= 21
      false
    else
      true
    end
  end

  def draw_hand_hidden
    puts "#{@name}'s hand: "
    puts '*' * 30
    print '| ? | ' * @hand.size
    puts
  end
end
