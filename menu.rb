module Menu
  def main_menu
    puts 'Game Menu'
    puts
    puts '1. New Game'
    puts '2. Exit'
    user_input = gets.to_i
    case user_input
    when 1
      new_game
    when 2
      puts 'GoodBye!'
      exit
    end
  end

  def new_game
    print 'Enter your name: '
    name = gets.strip.capitalize
    @player = Player.new(name)
    @dealer = Dealer.new
    @deck = Deck.new
    new_round
  end

  def new_round
    system 'clear'
    2.times{ @player.take_card(@deck) }
    2.times{ @dealer.take_card(@deck) }
    round_state
  end



  def round_state
    @player.draw_hand
    puts
    @dealer.draw_hand
    puts
  end
end
