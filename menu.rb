module Menu
  def main_menu
    puts 'Game Menu'
    puts
    puts '1. New Game'
    puts '2. Exit'
  end

  def new_game
    print 'Enter your name: '
    @player = Player.new(gets.strip.capitalize)
    @dealer = Dealer.new
    @deck = Deck.new
    new_round
  end

  def new_round
    2.times(@player.take_card(@deck))
    2.times(@dealer.take_card(@deck))
  end

  def another_card?
    print 'One more card?(1:take card, 2:pass): '
    user_input = gets.strip
    user_input == '1'
  end
end
