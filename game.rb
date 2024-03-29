# frozen_string_literal: true

# main game actions
class Game
  attr_reader :player, :dealer, :deck, :bet, :bank

  BET = 10
  def initialize(player, dealer, deck)
    @player = player
    @dealer = dealer
    @deck = deck
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
    @player.points = 0
    @dealer.points = 0
    @dealer.hidden = true
    @deck = Deck.new
    place_bets
    2.times { @player.take_card(@deck) }
    2.times { @dealer.take_card(@deck) }
  end

  def check_victory
    if @player.points > @dealer.points && @player.points <= 21
      player_wins
    elsif @player.points > 21 && @dealer.points > 21 || @player.points == @dealer.points
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
    @player.balance += @bank
    @player
  end

  def dealer_wins
    @dealer.balance += @bank
    @dealer
  end

  def check_balance
    :dealer_lose if @dealer.balance.zero?
    :player_lose if @player.balance.zero?
  end

  def draw
    @player.balance += @bet
    @dealer.balance += @bet
  end
end
