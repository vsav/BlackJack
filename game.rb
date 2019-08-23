# frozen_string_literal: true

# main game actions
class Game
  attr_reader :player, :dealer, :deck, :bet, :bank
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
    @interface.player_wins
    @player.balance += @bank
    dealer_lose if @dealer.balance.zero?
  end

  def dealer_wins
    @interface.dealer_wins
    @dealer.balance += @bank
    player_lose if @player.balance.zero?
  end

  def dealer_lose
    @interface.dealer_lose
    @interface.main_menu
  end

  def player_lose
    @interface.player_lose
    @interface.main_menu
  end

  def draw
    @interface.draw
    @player.balance += @bet
    @dealer.balance += @bet
  end

  def round_state
    @interface.draw_hand(@player)
    @interface.draw_balance(@player)
    @dealer.hidden ? @interface.draw_hand_hidden(@dealer) : @interface.draw_hand(@dealer)
    @interface.draw_balance(@dealer)
  end

  def round_summary
    @dealer.hidden = false
    round_state
  end
end
