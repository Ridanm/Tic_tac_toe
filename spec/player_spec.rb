require './lib/player.rb'

describe Player do 
	let(:player) { double('Player', letter: 'o') }

	before :each do 
		@player = Player.new 
	end

	it 'when enter name' do 
		allow(@player).to receive(:gets).and_return('name')
		expect(@player.player_name).to eq('name')
	end

	it 'select letter to play' do 
		allow(@player).to receive(:gets).and_return('x')
		expect(@player.choose_letter).to eq('x')
	end

	it 'if the player change the letter' do 
		expect(player.letter).to_not eq('x')
	end
end 

