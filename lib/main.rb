# frozen_string_literal: true
  
require_relative 'dependencies'

Board.new
player_one = Player.new
player_two = Player.new

puts Info::WELCOME

puts "\nPlayer one !!!".blue
player_one.player_name
player_one.choose_letter

puts "\nPlayer two !!!".green
player_two.player_name

if player_one.letter == 'x'
  player_two.letter = 'o'
else
  player_two.letter = 'x'
end

game = Game.new(player_one, player_two)
game.play
