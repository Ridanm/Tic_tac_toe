require_relative 'dependencies.rb'
require 'colorize'

board = Board::new
player_one = Player.new
player_two = Player.new 

puts Info::WELCOME

puts "\nPlayer one !!!"
player_one.player_name
player_one.choose_letter

puts "\nPlayer two !!!"
player_two.player_name

if player_one.letter == 'x' 
  player_two.letter = 'o'
else 
  player_two.letter = 'x'
end

game = Game::new(player_one, player_two)
game.select_position!

result = false 
until result 
  print "\nPLAY AGAIN type => yes or any key to exit: ".yellow
  result = gets.chomp.downcase
  if result == 'yes'
    game = Game::new(player_one, player_two)
    game.select_position!
    result = false 
  else 
    puts 'Thanks for playing!!!'.green  
    result = true 
  end
end

