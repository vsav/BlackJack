# frozen_string_literal: true

require_relative './card'
require_relative './deck'
require_relative './person'
require_relative './player'
require_relative './dealer'
require_relative './game'
require_relative './interface'

@deck = Deck.new
@player = Player.new('Player1')
@dealer = Dealer.new
@game = Game.new(@player, @dealer, @deck)
@interface = Interface.new(@game)
@interface.main_menu
