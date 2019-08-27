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
    puts 'Welcome to BlackJack game'
    print 'Please enter your name '
    begin
      player_name = gets.strip.capitalize
      raise 'Name cant be blank' if player_name.to_s.empty?
    rescue RuntimeError => e
      puts e.message
      retry
    end
    @game.new_game(player_name)
    system 'clear'
    game_state
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
    @game.dealer.hidden = false
    system 'clear'
    game_state
    send(@game.check_victory)
    send(@game.check_balance) unless @game.check_balance.nil?
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
      system 'clear'
      game_state
      next_turn
    when 2
      main_menu
    end
  end

  def game_state
    draw_hand(@game.player)
    draw_balance(@game.player)
    @game.dealer.hidden ? draw_hand_hidden(@game.dealer) : draw_hand(@game.dealer)
    draw_balance(@game.dealer)
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
    puts "#{person.name}'s balance: $#{person.balance}"
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
    puts 'You won this round!'
    puts "$#{@game.bank} was added to your balance"
    puts
  end

  def dealer_wins
    puts 'You lose this round!'
    puts "$#{@game.bet} was removed from your balance"
    puts
  end

  def dealer_lose
    puts 'You won the game!'
    puts 'Press any key to return to main menu'
    gets
    main_menu
  end

  def player_lose
    puts 'Your balance is empty!'
    puts 'Press any key to return to main menu'
    gets
    main_menu
  end

  def draw
    puts 'DRAW!'
    puts 'Your bet was returned to your balance'
    puts
  end
end
