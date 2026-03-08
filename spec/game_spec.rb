# frozen_string_literal: true

require '../lib/dependencies'

RSpec.describe Game do
  let(:player_one) { instance_double('Player', name: 'Player_one', letter: 'x') }
  let(:player_two) { instance_double('Player', name: 'Player_two', letter: 'o') }
  let(:board) { instance_double('Board') }

  subject(:game) { described_class.new(player_one, player_two) }

  before do
    allow(game).to receive(:show_board)
  end

  context '#initialize' do
    it 'with player_one' do
      expect(player_one).to respond_to(:name)
    end

    it 'with player_two' do
      expect(player_two).to respond_to(:letter)
    end

    it 'the name of the first player' do
      expect(player_one.name).to eq('Player_one')
    end

    it 'the letter of the second player' do
      expect(player_two.letter).to eq('o')
    end

    it 'with a Board' do
      expect(game.board_data).to be_an_instance_of(Array)
    end

    it 'with num based on the size of the board ' do
      expect(game.num).to eq(9)
    end
  end

  describe '#play' do
    context 'When does the game begin' do
      it 'when you call @board.show_board at startup' do
        expect(board).to receive(:show_board)
        board.show_board
      end

      it 'when the dashboard first appears' do
        size = game.board_data.size
        expect(size).to eq(10)
      end
    end
  end

    describe '#current_player!' do
      it 'if the number is odd' do
      expect(game.current_player!(1)).to eq(player_one)
      end

      it 'if the number is even' do
      expect(game.current_player!(2)
).not_to eq(player_one)
    end

    it 'when number is 1' do
      expect(player_one.name).to eq('Player_one')
    end
  end

  describe 'Info module' do
    context 'player name, select an empty box' do
      it 'when player_two' do
        expect(Info).to receive(:show).with('free_position', player_two.name).and_return('Player_two', 'select a free position in the board: ').once.time
        Info::show('free_position', player_two.name)
      end
    end
  end

  describe '#check_free_position' do
    it 'when the box is occupied, or the number is not between 1 and 9' do
      expect(Info).to receive(:show).with('filled').and_return('Thath position is already filled, or the character
does not match...')
      Info::show('filled')
    end
   
    it 'When you enter a correct number' do
      allow(player_one).to receive(:gets).and_return(3)
      game.check_free_position(3)
      expect(game.board.board_data[3]).to eq('x')
      # check_free_position(3)
    end
  end

  describe '#winner_or_draw' do
    let(:check_winner) { [[1, 2, 3], [4, 5, 6]] }
    context '#winner' do
      before do
        game.board.board_data[1] ='x'
        game.board.board_data[2] = 'x'
        game.board.board_data[3] = 'x'
      end

      it 'if return true' do
        expect(game.winner?(check_winner, player_one)).to be true
      end

      it 'if return false' do
        expect(game.winner?(check_winner, player_two)).to be false
      end
    end

    context '#board_full?' do
      it 'when there are no more movements' do
        (1..9).each { |i| game.board.board_data[i] = 'x' }
        expect(game.board_full?(game.board.board_data)).to be true
      end

      it 'when the board is not full?' do
        expect(game.board_full?(game.board.board_data)).to be false
      end

      it 'we display the message' do
        expect(Info).to receive(:show).with('draw').and_return("\n  ---  Is a draw!!!  ---".green)
        Info::show('draw')
      end
    end
 
    describe '#game_over' do
      it 'while the game is running' do
        expect(Info).to receive(:show).with('play_again').and_return("\nPLAY AGAIN type => yes or any key to exit: ".yellow)
        Info::show('play_again')
      end

      context '#continue_or_exit' do
        it 'When does it end, do we repeat the game or not?' do
          expect(game).to receive(:gets).and_return('yes')
          game.continue_or_exit
        end
      end

      context '#repeat_game' do
        it 'when you want to repeat the game' do
          expect(game).to receive(:play)
          game.play
        end
      end
    end
  end


=begin
    context 'when the game ends in a draw' do
      xit 'plays through all moves and ends the game' do
        game.instance_variable_set(:@num, 9)
        allow(game).to receive(:current_player!)
        allow(Info).to receive(:show)
        allow(game).to receive(:if_winner_or_draw)
        allow(game).to receive(:winner?).and_return(false)
        allow(game).to receive(:gets).and_return('1', '2', '3', '4', '5', '6', '7', '8', '9')
        num = 9
        allow(game).to receive(:check_free_position) do
          num -= 1
          game.instance_variable_set(:@num, num)
        end

        game.play
        expect(game).to have_received(:current_player!).exactly(9).times
        expect(game.instance_variable_get(:@num)).to eq(0)
      end
    end

    context 'when a player wins' do
      xit 'ends the game early' do
        game.instance_variable_set(:@num, 9)
        allow(game).to receive(:current_player!)
        allow(game).to receive(:check_free_position)
        move_count = 0
        allow(game).to receive(:winner?).and_wrap_original do
          move_count += 1
          move_count == 3
        end
        allow(game).to receive(:game_over)
        allow(game).to receive(:gets).and_return('1', '2', '3')
        num = 9
        allow(game.instance_variable_set(:@num, num))
        allow(game).to receive(:check_free_position) do
        num -= 1
        game.instance_variable_set(:@num, num)
        end
        
        game.play
        # expect(game).to have_received(:game_over).with(true).once
        expect(move_count).to eq(3)
        expect(game.instance_variable_get(:@num, 6))
      end
    end
  end

  context '#winner' do
    xit 'when there are three consecutive symbols in a line' do
      expect(position.all?(player_one.letter)).to be true
    end

    xit 'when the three letters are not consecutives' do
      expect(position.all?(player_two.letter)).to_not be true
    end
  end

  context '#board full' do
    xit 'after 7 turns' do
      full = [0, '1', '2', '3', '4', '5', '6', '7', 8, 9]
      expect(game.board_full?(full)).to be false
    end

    xit 'after 9 turns all numbers in the board are letters' do
      full = [0, 'x', '0', 'x', '0', 'x', '0', 'x', 'x', 'x']
      expect(game.board_full?(full)).to be true
    end
  end
=end
end
