# frozen_string_literal: true

require './lib/dependencies'

RSpec.describe Info do
  let(:name) { 'Rob' }

  describe 'WELCOME message' do
    it 'contains the correct message' do
      welcome_message = "\e[0;33;49m\n---  WELCOME TO TIC_TAC_TOE GAME  ---\e[0m"
      expect(Info::WELCOME).to eq(welcome_message)
    end

    it 'is yellow start_with' do
      expect(Info::WELCOME).to start_with("\e[0;33;49m")
    end

    it 'is yellow end_with' do
      expect(Info::WELCOME).to end_with('[0m')
    end
  end

  describe 'CheckWimner comstant' do
    it 'contains the winning combinations' do
      expected = [
        [1, 2, 3], [4, 5, 6], [7, 8, 9],
        [1, 4, 7], [2, 5, 8], [3, 6, 9],
        [1, 5, 9], [3, 5, 7]
      ]
      expect(Info::CheckWinner).to eq(expected)
    end

    it 'is frozen' do
      expect(Info::CheckWinner).to be_frozen
    end

    describe '#show' do
      context 'when the parameter is free_position' do
        it 'when the parameter is filled' do
          message_filled = "\nThath position is already filled, or the character does not match...".light_red
          expect(Info.show('filled', name)).to eq(message_filled)
        end

        it 'when the parameter is winner' do
          message_winner = "\n  ---  Congratulations #{name} is the winner!!!  ---".green
          expect(Info.show('winner', name)).to eq(message_winner)
        end

        it 'when the parameter is draw' do
          message_draw = "\n  ---  Is a draw!!!  ---".green
          expect(Info.show('draw', name)).to eq(message_draw)
        end

        it 'returns the formatted message with the name in green' do
          message = Info.show('free_position', 'Rob')
          expect(message).to eq("#{'Rob'.green} select a free position in the board: ")
        end

        it 'when the parameter is enter_letter' do
          message_enter_letter = "\n#{name.blue} enter the letter you want to play with it can be: X or: O => "
          expect(Info.show('enter_letter', name)).to eq(message_enter_letter)
        end
      end
    end
  end
end
