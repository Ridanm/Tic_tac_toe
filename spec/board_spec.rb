require '../lib/dependencies'

RSpec.describe Board do 
  subject(:board) { Board.new }
  let(:data) { board.board_data }
  let(:game) { instance_double('Game') }
  let(:player) { instance_double('Player') }
        
  describe '#initialize' do
    it 'when instantiating the class' do
      expect(data).to be_a(Array)
    end

    it 'create  board' do
      expect(data.size).to eq(10)
    end

    it 'does it include the numbers?' do 
      expect(data).to include(1..9)
    end
  end

  describe '#show_board' do
    it 'the board at the start' do
      expected_output = "\n1 | 2 | 3\n--+---+--\n4 | 5 | 6\n--+---+--\n7 | 8 | 9\n\n"
      expect{ board.show_board }.to output{expected_output}.to_stdout
    end

    it 'when a player selects box 2' do
      expect(player).to receive(:letter).and_return('x')
      expect(game).to receive(:check_free_position).with(2).and_return(data[2] = player.letter)
      game.check_free_position(2)
      expect(data[2]).to eq('x')
    end
  end
end
