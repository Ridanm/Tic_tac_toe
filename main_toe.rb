require './tic_tac_toe'

def play
  board = Board::new
  player_one = Player::new
  player_two = Player::new 

  puts Info::WELCOME

  puts "Player one !!!"
  player_one.player_name 
  player_one.choose_letter

  puts "Player two !!!"
  player_two.player_name 

  if player_one.letter == 'x' 
    player_two.letter = 'o'
  else 
    player_two.letter = 'x'
  end

  game = Game::new(player_one, player_two)
  game.select_position!
end 

def play_again
  print "\nPLAY AGAIN PRESS => yes or no: "
  yes = gets.chomp
  if yes == 'yes'
    play 
  else
    puts 'Thanks for playing'
  end
  puts 
end

play 
play_again

