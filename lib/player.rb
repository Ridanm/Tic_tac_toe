class Player 
  attr_reader :name
  attr_accessor :letter
  
  def player_name
    print 'Enter your name: '
    @name = gets.chomp 
    player_name if @name == ''
    @name 
  end
  
  def choose_letter
    puts "\nEnter the letter you want to play with it can be: X or: O"
    @letter = gets.chomp.downcase
    choose_letter unless @letter == 'x' || @letter == 'o'
    @letter
  end
end
  