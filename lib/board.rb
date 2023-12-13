require 'colorize'

class Board 
  attr_reader :board
  
  def initialize
    @board = []
    create_board
  end
  
  def create_board
    (0..9).each do |position|
      @board << position
    end
		@board 
  end
  
  def show_board
    col_separator, row_separator = " | ".blue, "--+---+--".blue 
    label_for_position = lambda{|position| @board[position] ? @board[position] : position}
    row_for_display = lambda{|row| row.map(&label_for_position).join(col_separator)}
     
    row_positions = [[1,2,3], [4,5,6], [7,8,9]]
    rows_for_display = row_positions.map(&row_for_display)
    puts "\n#{rows_for_display.join("\n" + row_separator + "\n")}\n\n"
  end
  
  def to_s 
    "#{@board}"
  end
end
