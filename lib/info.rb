# frozen_string_literal: true

require 'colorize'

# This module implements the presentation and what corresponds to the text to be displayed
module Info
  WELCOME = "\n---  WELCOME TO TIC_TAC_TOE GAME  ---".yellow
  CheckWinner = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

  def self.show(parameter, name = 'Anonimus')
    {
      'filled' => "\nThath position is already filled, or the character does not match...".light_red,
      'winner' => "\n  ---  Congratulations #{name} is the winner!!!  ---".green,
      'draw' => "\n  ---  Is a draw!!!  ---".green,
      'free_position' => "#{name.green} select a free position in the board: ",
      'enter_letter' => "\n#{name.blue} enter the letter you want to play with it can be: X or: O => ",
      'play_again' => "\nPLAY AGAIN type => yes or any key to exit: ".yellow
    }[parameter]
  end
end
