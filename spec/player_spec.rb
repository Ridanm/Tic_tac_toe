require './tic_tac_toe.rb'

describe 'Player class' do 
	before :each do 
		@player = Player.new 
	end

	it 'enter name' do 
		expect(@player.player_name).to eq 'Roberto'
	end
end 