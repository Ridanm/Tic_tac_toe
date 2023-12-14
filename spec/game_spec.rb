require 'dependencies' 

RSpec.describe Game do 
	let(:player_one) { double('Player', name: 'Player_one') }
	let(:player_two) { double('Player', name: 'Player_two') }

	before { @game = Game.new(player_one, player_two) }

	context '#initialize' do 
		it 'with player_one' do 
			expect(@game.player_one).to eq(player_one)
		end

		it 'with player_two' do 
			expect(@game.player_two).to eq(player_two)
		end

		it 'with a Board' do 
			expect(@game.board).to be_an_instance_of(Board)
		end
	
		it 'with num based on the size of the board ' do 
			expect(@game.num).to eq(@game.board.board.size - 1)
		end
	end

	context '#select_position!' do 
		it 'when check_free_position' do 
			expect(@game.check_free_position(1)).to eq(1)
		end

		it 'when is ocuped' do
			expect(@game.check_free_position(1)).to be('x')
		end
	end

	context '#change_player!' do 
		it 'changes the current player based on the player number' do 
			expect(@game.player_one).to eq(player_one)
			expect(@game.change_player!(2)).to eq(player_two)
		end
	end

	context '#winner'
end