# TIC TAC TOE ---
# clase Board
  # Crear tablero --- board
  # Formatear tablero 
  # Mostrar tablero
# clase Player
  # Ingrese el nombre del jugador numero 1 --- player_name 
  # Elegir la letra con la que juega letra X o letra 0 --- chose_letter
  # Validar que la letra sea X o la O --- 
  # Ingrese el nombre del segundo jugador --- player_name
  # Mostrar nombre y letra segundo jugador --- show_player
# clase Game
  # Comienza el juego --- star_game
  # Elije cuadro libre nombre del jugador 1
  # Validar que la posición este etre 1 y 9
  # Validar que la posición no esté ocupada
  # verificar ganador --- @ganador
  # Tablero lleno termina el juego mostrar empate  --- @ganador
  # Mostrar tablero  --- board
  # Nombre del ganador si lo hay de lo contrario  --- @ganador


module Info
  WELCOME = '---  WELCOME TO TIC_TAC_TOE GAME  ---'
end

class Board 
  attr_reader :board

  def initialize
    @board = []
    create_board
  end

  def create_board
    (0..9).each do |let|
      @board << let
    end
  end

  def show_board
    col_separator, row_separator = " | ", "--+---+--"
    label_for_position = lambda{|position| @board[position] ? @board[position] : position}
    row_for_display = lambda{|row| row.map(&label_for_position).join(col_separator)}
   
    row_positions = [[1,2,3], [4,5,6], [7,8,9]]
    rows_for_display = row_positions.map(&row_for_display)
    puts rows_for_display.join("\n" + row_separator + "\n")
  end

  def to_s 
    "#{@board}"
  end
end


class Player 
  attr_reader :name
  attr_accessor :letter

  def initialize
    @data = {}
  end

  def player_name
    print 'Enter your name: '
    @name = gets.chomp 
  end

  def choose_letter
    until @letter == 'x' || @letter == 'o'
      print 'Enter the letter with which you will play => x <=, => o <= '
      @letter = gets.chomp 
    end
  end
end


class Game < Board 
  attr_reader :player_one, :player_two, :board, :num 

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @board = Board::new 
  end

  def select_position! player 
    @num = @board.board.size - 1
    @board.show_board
    puts "@num = #{@num}"
    while @num > 0
      puts "#{player.name.capitalize} select a free position in the board: "
      @position = gets.chomp.to_i 
      verifier_free_position player
      @board.show_board 
    end
  end

  def change_player 
    # Usar argumento como @num para cambiar jugador 
    puts @num 
    # cambiar de jugador segun el número
    # @num no se lee desde acá 
  end


  def verifier_free_position player
      if @position.between?(1, 9) && @board.board[@position].class != ''.class 
        @board.board[@position] = player.letter  
        @num -= 1
      else 
        puts "Casillero ocupado !!!"
      end
  end

  def winner

  end
end

class Display
  attr_reader :board

  def initialize
    @board = Board.new 
  end
  
  def display_board
    puts @board.show_board.class 
  end
end


class Main 
  
end

# Iniciando participantes y letras 
board = Board::new
player_one = Player::new
player_two = Player::new 

puts Info::WELCOME

puts "Player one !!!"
player_one.player_name 
player_one.choose_letter

puts "Player two !!!"
player_two.player_name 

if player_one.letter == 'x' 
  player_two.letter = 'o'
else 
  player_two.letter = 'x'
end

# Comienza el juego 
game = Game::new(player_one, player_two)
#game.select_position!
game.change_player