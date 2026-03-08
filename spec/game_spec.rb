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
      expect(game.current_player!(2)).not_to eq(player_one)
    end

    it 'when number is 1' do
      expect(player_one.name).to eq('Player_one')
    end
  end

  describe 'Info module' do
    let(:player_two_msj) { 'select a free position in the board: ' }

    context 'player name, select an empty box' do
      it 'when player_two' do
        expect(Info).to receive(:show).with('free_position', player_two.name).and_return('Player_two',
                                                                                         player_two_msj).once.time
        Info.show('free_position', player_two.name)
      end
    end
  end

  describe '#check_free_position' do
    it 'when the box is occupied, or the number is not between 1 and 9' do
      expect(Info).to receive(:show).with('filled').and_return('Thath position is already filled, or the character
does not match...')
      Info.show('filled')
    end

    it 'When you enter a correct number' do
      allow(player_one).to receive(:gets).and_return(3)
      game.check_free_position(3)
      expect(game.board.board_data[3]).to eq('x')
    end
  end

  describe '#winner_or_draw' do
    let(:check_winner) { [[1, 2, 3], [4, 5, 6]] }
    context '#winner' do
      before do
        game.board.board_data[1] = 'x'
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
  end

  describe '#board_full?' do
    it 'when there are no more movements' do
      (1..9).each { |i| game.board.board_data[i] = 'x' }
      expect(game.board_full?(game.board.board_data)).to be true
    end

    it 'when the board is not full?' do
      expect(game.board_full?(game.board.board_data)).to be false
    end

    it 'we display the message' do
      expect(Info).to receive(:show).with('draw').and_return("\n  ---  Is a draw!!!  ---".green)
      Info.show('draw')
    end
  end

  describe '#game_over' do
    let(:play_msj) { "\nPLAY AGAIN type => yes or any key to exit: ".yellow }

    it 'while the game is running' do
      expect(Info).to receive(:show).with('play_again').and_return(play_msj)
      Info.show('play_again')
    end

    context '#continue_or_exit' do
      it 'When the game ends and we repeat it' do
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

    context 'exiting the game' do
      it 'When the game ends and we leave' do
        expect(game).to receive(:game_over).and_return('Thanks for playing!!!')
        game.game_over
      end
    end
  end
end
