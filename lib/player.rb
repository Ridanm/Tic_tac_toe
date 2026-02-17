# frozen_string_literal: true

require_relative 'dependencies'

# This class implements the player and the choice of the letter to play
class Player
  attr_accessor :name, :letter

  include Info

  def enter_name
    print 'Enter your name: '
    @name = gets.chomp.capitalize.strip.squeeze(' ')
    enter_name if @name == '' || @name == ' '
    @name
  end

  def choose_letter
    print Info.show('enter_letter', name)
    @letter = gets.chomp.downcase
    choose_letter unless @letter == 'x' || @letter == 'o'
    @letter
  end
end
