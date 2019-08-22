class Interface
  attr_reader :user_input

  def main_menu
    system 'clear'
    puts 'Black Jack'
    puts
    puts '1. New Game'
    puts '2. Exit'
  end

  def new_game
    system 'clear'
    puts 'Welcome to BlackJack'
    puts 'Please enter your name'
  end

  def another_round
    puts 'One more round?(1:yes 2:main menu) '
  end
end
