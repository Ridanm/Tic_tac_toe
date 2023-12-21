require './lib/board.rb'

RSpec.describe Board do 
	let(:board) { Board.new }  

	it '#initialize' do 
		expect(board.board).to be_a(Array)
	end

	it 'create board' do 
		expect(board.board).to include(0..9)
  end
end