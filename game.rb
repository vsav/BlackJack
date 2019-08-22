class Game
  attr_reader :player, :dealer, :deck
  BET = 10
  def initialize(player, dealer, deck)
    @player = player
    @dealer = dealer
    @deck = deck
    @interface = Interface.new
    @bet = BET
    @bank = 0
  end

  def main_menu
    @interface.main_menu
    begin
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
    @interface.new_game
    begin
      name = gets.strip.capitalize
      raise 'Name cant be blank' if name.to_s.empty?
    rescue RuntimeError => e
      puts e.message
      retry
    end
    @player = Player.new(name)
    @dealer = Dealer.new
    new_round
  end

  def new_round
    @player.hand = {}
    @dealer.hand = {}
    @deck = Deck.new
    system 'clear'
    place_bets
    2.times { @player.take_card(@deck) }
    2.times { @dealer.take_card(@deck) }
    round_state
    @player.take_card(@deck) if @player.another_card?
    @dealer.take_card(@deck) if @dealer.another_card?
    system 'clear'
    round_summary
    check_victory
    another_round
  end

  def another_round
    @interface.another_round
    begin
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
  end

  def place_bets
    @player.balance -= @bet
    @dealer.balance -= @bet
    @bank = @bet * 2
  end

  def player_wins
    puts 'PREY SLAUGHTERED!'
    puts
    @player.balance += @bank
    dealer_loose if @dealer.balance.zero?
  end

  def dealer_wins
    puts 'YOU DIED!'
    puts
    @dealer.balance += @bank
    player_loose if @player.balance.zero?
  end

  def dealer_loose
    puts 'You won the game!'
    puts 'Press any key to return to main menu'
    gets
    main_menu
  end

  def player_loose
    puts 'Your balance is empty!'
    puts 'Press any key to return to main menu'
    gets
    main_menu
  end

  def draw
    puts 'DRAW!'
    puts
    @player.balance += @bet
    @dealer.balance += @bet
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
