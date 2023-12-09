class Game < Board 
  attr_reader :player_one, :player_two, :board, :num 
  include Info 
  
  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @board = Board::new
    @num = @board.board.size - 1
  end
  
  def select_position!
    puts "\n#{@board.show_board}"

    while @num > 0
      change_player! @num
      print "#{@player.name.capitalize.yellow} select a free position in the board: "
      @position = gets.chomp.to_i 
      check_free_position @player
      puts "\n#{@board.show_board }"
      
      if winner @player 
        puts "\n  ---  Congratulations #{@player.name.capitalize} is the winner!!!  ---".blue  
        return 
      elsif board_full? @board 
        puts "\n  ---  Is a draw!!!  ---".ligth_green 
        return 
      end
    end
  end
  
  def change_player! player
    if player.odd?
      @player = @player_one
    else
      @player = @player_two
    end
  end
  
  def check_free_position player
    if @position.between?(1, 9) && @board.board[@position].class != ''.class 
      @board.board[@position] = player.letter  
      @num -= 1
    else 
      puts "\nThath position is occupied, or the character does not match..."
    end
  end
  
  def winner player
    CHECK_WINNER.any? do |line|
      line.all? {|pos| @board.board[pos] == player.letter}
    end
  end

  def board_full? board 
    (1..9).all? {|pos| board.board[pos].is_a?(String) }
  end
  
  def to_s
    puts "#{@board}"
  end
end