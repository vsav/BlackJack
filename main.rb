require_relative './deck.rb'
require_relative './person.rb'
require_relative './player.rb'
require_relative './dealer.rb'

@deck = Deck.new
@player = Player.new
puts @deck
puts @player
@player.take_card(@deck)
@player.take_card(@deck)
@player.take_card(@deck)
@player.hand