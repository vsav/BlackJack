require_relative './card.rb'
require_relative './deck.rb'
require_relative './person.rb'
require_relative './player.rb'
require_relative './dealer.rb'
require_relative './game.rb'
require_relative './interface.rb'

@deck = Deck.new
@player = Player.new('Player1')
@dealer = Dealer.new
@game = Game.new(@player, @dealer, @deck)
@interface = Interface.new(@game)
@interface.main_menu
