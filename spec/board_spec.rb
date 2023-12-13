require './lib/board.rb'

RSpec.describe Board do 
	let(:board) { Board.new }  

	it '#initialize' do 
		expect(board.board).to be_a(Array)
	end

	it 'create #Board' do 
		expect(board.create_board).to be_a(Array)
  end

	it 'when creating the board you must include the numbers 0 to 9' do 
		expect(board.create_board).to include(0..9)
	end
end