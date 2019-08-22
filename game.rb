class Game
  attr_reader :player, :dealer, :deck
  BET = 10
  def initialize(player, dealer, deck)
    @player = player
    @dealer = dealer
    @deck = deck
    @interface = Interface.new(self)
    @bet = BET
    @bank = 0
  end

  def new_game(player_name)
    @player = Player.new(player_name)
    @dealer = Dealer.new
    new_round
  end

  def new_round
    @player.hand = []
    @dealer.hand = []
    @dealer.hidden = true
    @deck = Deck.new
    system 'clear'
    place_bets
    2.times { @player.take_card(@deck) }
    2.times { @dealer.take_card(@deck) }
    round_state
  end

  def game_state
    round_summary
    puts
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
    @interface.main_menu
  end

  def player_loose
    puts 'Your balance is empty!'
    puts 'Press any key to return to main menu'
    gets
    @interface.main_menu
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
    @player.draw_balance
    puts
    @dealer.hidden ? @dealer.draw_hand_hidden : @dealer.draw_hand
    puts
    @dealer.draw_balance
    puts
  end

  def round_summary
    @dealer.hidden = false
    round_state
  end
end
