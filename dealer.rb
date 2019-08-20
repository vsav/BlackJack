class Dealer < Person
  def initialize
    super
  end

  def limit?
    count_points
    if @points > 21
      false
    elsif @points >= 17 && @points <= 21
      false
    else
      true
    end
  end

  def draw_hand
    print '| ? | ' * @hand.size
  end
end
