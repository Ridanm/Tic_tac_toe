# frozen_string_literal: true

require 'colorize'

# This class makes the game board
class Board
  attr_reader :board_data

  def initialize
    @board_data = (0..9).to_a
  end

  def show_board
    col_separator = ' | '.blue
    row_separator = '--+---+--'.blue
    label_for_position = ->(position) { @board_data[position] || position }
    row_for_display = ->(row) { row.map(&label_for_position).join(col_separator) }

    row_positions = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    rows_for_display = row_positions.map(&row_for_display)
    puts "\n#{rows_for_display.join("\n#{row_separator}\n")}\n\n"
  end
end
