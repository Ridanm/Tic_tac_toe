# frozen_string_literal: true

require_relative 'dependencies'

# This class implements player swapping and determines the winner if there is one.
class Game < Board
  attr_reader :player_one, :player_two, :board, :num

  include Info

  def initialize(player_one, player_two)
    super()
    @player_one = player_one
    @player_two = player_two
    @board = Board.new
    @num = @board.board_data.size - 1
  end

  def select_position!
    @board.show_board
    while @num.positive?
      change_player! @num
      print Info.show('free_position', @player.name)
      position = gets.chomp.to_i
      check_free_position position
      @board.show_board

      if_winner?
    end
  end

  def if_winner?
    if winner? CHECK_WINNER, @player
      return puts Info::show('winner', @player.name)
    elsif board_full? @board.board_data
      return puts Info::show('draw')
    end
  end

  def change_player!(num)
    @player = num
    @player = @player.odd? ? @player_one : @player_two
  end

  def check_free_position(box)
    if @board.board_data[box] == 'x' || @board.board_data[box] == 'o' || !box.between?(1, 9)
      puts Info.show('filled')
    elsif box.between?(1, 9) && box.instance_of?(Integer)
      @board.board_data[box] = @player.letter
      @num -= 1
    end
  end

  def winner?(check_array, player)
    player = player.letter
    check_array.any? do |line|
      line.all? { |pos| @board.board_data[pos] == player }
    end
  end

  def board_full?(board)
    board[1, 9].all? { |pos| pos.is_a?(String) }
  end
end
