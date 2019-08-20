require_relative './deck.rb'
require_relative './person.rb'
require_relative './player.rb'
require_relative './dealer.rb'
require_relative './menu.rb'
include Menu
#@deck = Deck.new
#@deck1 = Deck1.new
#@player = Player.new
#@dealer = Dealer.new

main_menu
@player.take_card(@deck) if @player.another_card?
@dealer.take_card(@deck) if @dealer.another_card?
round_state


#puts @deck
#puts @player
#@player.take_card(@deck)
#@player.take_card(@deck)
#@player.take_card(@deck)
#@player.hand = { "A\u2660" => 11, "A\u2663" => 11, "A\u2665" => 11 }
#puts @player.hand
#@dealer.take_card(@deck)
#@dealer.take_card(@deck)
#@dealer.take_card(@deck)
#puts @dealer.hand
