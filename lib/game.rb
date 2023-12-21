require_relative 'dependencies'

class Game < Board 
  attr_reader :player_one, :player_two, :board, :num 
  include Info 
   
  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @board = Board.new
    @num = @board.board.size - 1
  end
  
  def select_position!
    @board.show_board

    while @num > 0
      change_player! @num
      print Info::show('free_position', @player.name)
      @position = gets.chomp.to_i 
      check_free_position @position
      @board.show_board
      
      if winner? CHECK_WINNER, @player 
        puts Info::show('winner', @player.name) 
        return 
      elsif board_full? @board.board
        puts Info::show('draw') 
        return 
      end
    end
  end
  
  def change_player! player
      @player = @player_one if player.odd?
      @player = @player_two if player.even? 
  end
  
  def check_free_position box
    if @board.board[box] == 'x' || @board.board[box] == 'o' || !box.between?(1, 9)
      puts Info::show('filled')
    elsif box.between?(1, 9) && box.class == Integer
      @board.board[box] = @player.letter 
      @num -= 1
    end
  end
  
  def winner? check_array, player
    player =  player.letter
    check_array.any? do |line|
      line.all? {|pos| @board.board[pos] == player}
    end
  end

  def board_full? board 
    board[1, 9].all? { |pos| pos.is_a?(String) }
  end
end