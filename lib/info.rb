require 'colorize'

module Info
  WELCOME = "\n---  WELCOME TO TIC_TAC_TOE GAME  ---".yellow 
  CHECK_WINNER = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

  def self.show(parameter, name='Robert')
    {
      'filled' => "\nThath position is already filled, or the character does not match...".light_red,
      'winner' => "\n  ---  Congratulations #{name.capitalize} is the winner!!!  ---".green,
      'draw' => "\n  ---  Is a draw!!!  ---".green,
      'free_position' => "#{name.capitalize.yellow} select a free position in the board: "
    }[parameter]     
  end
end
  

  
  
