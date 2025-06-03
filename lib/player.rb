# frozen_string_literal: true

require_relative './dependencies'

# This class implements the player and the choice of the letter to play
class Player
  attr_reader :name
  attr_accessor :letter

  include Info

  def player_name
    print 'Enter your name: '
    @name = gets.chomp.capitalize.strip.squeeze
    player_name if @name == '' || @name == ' '
    @name
  end

  def choose_letter
    print Info::show('enter letter', name)
    @letter = gets.chomp.downcase
    choose_letter unless @letter == 'x' || @letter == 'o'
    @letter
  end
end
