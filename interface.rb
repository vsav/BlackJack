# frozen_string_literal: true

# CLI
class Interface
  def initialize(game)
    @game = game
  end

  def main_menu
    system 'clear'
    puts 'Black Jack'
    puts
    puts '1. New Game'
    puts '2. Exit'
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
    system 'clear'
    puts 'Welcome to BlackJack'
    print 'Please enter your name '
    begin
      player_name = gets.strip.capitalize
      raise 'Name cant be blank' if player_name.to_s.empty?
    rescue RuntimeError => e
      puts e.message
      retry
    end
    @game.new_game(player_name)
    next_turn
  end

  def next_turn
    print 'One more card?(1:take card, 2:pass, 3:open): '
    begin
      user_input = gets.to_i
      raise 'Please select 1, 2 or 3 ' unless [1, 2, 3].include?(user_input)
    rescue RuntimeError => e
      puts e.message
      retry
    end
    case user_input
    when 1
      @game.player.take_card(@game.deck)
      @game.dealer.next_turn(@game.deck)
    when 2
      @game.dealer.next_turn(@game.deck)
    end
    system 'clear'
    @game.game_state
    another_round
  end

  def another_round
    print 'One more round?(1:yes 2:main menu) '
    begin
      user_input = gets.to_i
      raise 'Please input 1 for New Round or 2 for Main Menu' unless [1, 2].include?(user_input)
    rescue RuntimeError => e
      puts e.message
      retry
    end
    case user_input
    when 1
      @game.new_round
      next_turn
    when 2
      main_menu
    end
  end

  def draw_hand(person)
    puts "#{person.name}'s hand: #{person.points} points total"
    puts '*' * 30
    person.hand.each do |card|
      print "|#{card.face}| "
    end
    puts
    puts
  end

  def draw_balance(person)
    puts "#{person.name}'s balance: #{person.balance}"
    puts
  end

  def draw_hand_hidden(person)
    puts "#{person.name}'s hand: "
    puts '*' * 30
    print '| ? | ' * person.hand.size
    puts
    puts
  end

  def player_wins
    puts 'PREY SLAUGHTERED!'
    puts
  end

  def dealer_wins
    puts 'YOU DIED!'
    puts
  end

  def dealer_loose
    puts 'You won the game!'
    puts 'Press any key to return to main menu'
    gets
  end

  def player_loose
    puts 'Your balance is empty!'
    puts 'Press any key to return to main menu'
    gets
  end

  def draw
    puts 'DRAW!'
    puts
  end
end
