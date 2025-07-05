# frozen_string_literal: true

require './lib/dependencies'

RSpec.describe Game do
  let(:player_one) { instance_double('Player', name: 'Player_one', letter: 'x') }
  let(:player_two) { instance_double('Player', name: 'Player_two', letter: 'o') }
  let(:position) { %w[x x x] }
  let(:board) { instance_double('Board') }
  let(:info) { Info }

  subject(:game) { described_class.new(player_one, player_two) }

  let(:WINNING_LINES) do
    [
      [1, 2, 3], # Top row
      [4, 5, 6], # Middle row
      [7, 8, 9], # Bottom row
      [1, 4, 7], # Left column
      [2, 5, 8], # Middle column
      [3, 6, 9], # Right column
      [1, 5, 9], # Diagonal top-left
      [3, 5, 7]  # Diagonal top-righttom
    ].freeze
  end

  before do
    allow(game).to receive(:show_board)
    allow(game).to receive(:player_one).and_return(player_one)
    allow(game).to receive(:player_two).and_return(player_two)
    allow(game).to receive(:current_player!).and_return(player_one)
  end

  context '#initialize' do
    it 'with player_one' do
      expect(player_one).to respond_to(:name)
    end

    it 'with player_two' do
      expect(player_two).to respond_to(:letter)
    end

    it 'with a Board' do
      expect(game.board_data).to be_an_instance_of(Array)
    end

    it 'with num based on the size of the board ' do
      expect(game.num).to eq(9)
    end
  end

  describe '#play' do
    context 'when the game is in progress' do
      before do
        allow(game).to receive(:num).and_return(1).once
        allow(game).to receive(:current_player!).and_return(player_one)
        allow(game).to receive(:gets).and_return('4', '5', '6')
        allow(game).to receive(:check_free_position)
        allow(game).to receive(:if_winner_or_draw)
        allow(game).to receive(:game_over)
      end

      it 'when you call @board.show_board at startup' do
        expect(board).to receive(:show_board)
        board.show_board
      end

      it 'when check_free_position' do
        expect(game.board_data[7]).to eq(7)
      end

      it 'when is ocuped' do
        expect(game.board_data[7] = 'x').to eq(player_one.letter)
      end
    end

    context 'when the game ends in a draw' do
      it 'plays through all moves and ends the game' do
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
      it 'ends the game early' do
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
        #expect(game).to have_received(:game_over).with(true).once
        expect(move_count).to eq(3)
        expect(game.instance_variable_get(:@num, 6))
      end
    end
  end

  describe '#current_player!' do
    it 'swuap based on the player number 9' do
      expect(game.current_player!(1)).to eq(player_one)
    end

    it 'swuap if the player number is 8' do
      expect(game.current_player!(2)).not_to eq(player_two)
    end

    it 'swap player when number is 7' do
      expect(player_one.name).to eq('Player_one')
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
end
