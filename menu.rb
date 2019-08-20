module Menu
  attr_reader :player, :dealer, :deck
  def main_menu
    system 'clear'
    begin
      puts 'Black Jack'
      puts
      puts '1. New Game'
      puts '2. Exit'
      user_input = gets.to_i
      raise 'Please enter 1 for New Game or 2 to Exit' unless [1, 2].include?(user_input)
    rescue RuntimeError => e
      puts e.message
      puts
      retry
    end
    case user_input
    when 1
      new_game
    when 2
      puts 'GoodBye!'
      exit
    end
  end

  def new_game
    begin
      print 'Enter your name: '
      name = gets.strip.capitalize
      raise 'Name cant be blank' if name.to_s.empty?
    rescue RuntimeError => e
      puts e.message
      retry
    end
    @player = Player.new(name)
    @dealer = Dealer.new
    @deck = Deck.new
    new_round
  end

  def new_round
    @player.hand = {}
    @dealer.hand = {}
    system 'clear'
    @player.place_bet
    @dealer.place_bet
    2.times { @player.take_card(@deck) }
    2.times { @dealer.take_card(@deck) }
    round_state
    @player.take_card(@deck) if player.another_card?
    @dealer.take_card(@deck) if dealer.another_card?
    system 'clear'
    round_summary
    check_victory
  end

  def check_victory
    @player.count_points
    @dealer.count_points
    if @player.points > @dealer.points && @player.points <= 21
      player_wins
    elsif @player.points >= 21 && @dealer.points >= 21 || @player.points == @dealer.points
      draw
    elsif @player.points > 21 && @dealer.points <= 21
      dealer_wins
    elsif @player.points < @dealer.points && @dealer.points <= 21
      dealer_wins
    elsif @player.points < @dealer.points && @dealer.points > 21
      player_wins
    end

    begin
      puts 'One more round?(1:yes 2:main menu) '
      user_input = gets.to_i
      raise 'Please input 1 for New Round or 2 for Main Menu' unless [1, 2].include?(user_input)
    rescue RuntimeError => e
      puts e.message
      retry
    end
    case user_input
    when 1
      new_round
    when 2
      main_menu
    end
  end

  def player_wins
    puts 'PREY SLAUGHTERED!'
    puts
    @player.balance += 20
    if @dealer.balance.zero?
      puts 'You won the game!'
      puts 'Press any key to return to main menu'
      gets
      main_menu
    end
  end

  def dealer_wins
    puts 'YOU DIED!'
    puts
    @dealer.balance += 20
    if @player.balance.zero?
      puts 'Your balance is empty!'
      puts 'Press any key to return to main menu'
      gets
      main_menu
    end
  end

  def draw
    puts 'DRAW!'
    puts
    @player.balance += 10
    @dealer.balance += 10
  end

  def round_state
    @player.draw_hand
    puts
    puts "#{@player.name}'s balance: #{@player.balance}"
    puts
    @dealer.draw_hand_hidden
    puts
    puts "#{@dealer.name}'s balance: #{@dealer.balance}"
    puts
  end

  def round_summary
    @player.draw_hand
    puts
    @dealer.draw_hand
    puts
  end
end
