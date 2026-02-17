# frozen_string_literal: true

require '../lib/dependencies'

RSpec.describe Player do
  let(:player) { described_class.new }
  before(:each) do
    allow(player).to receive(:gets).and_return('jose')
    allow(Info).to receive(:show).with('enter_letter', player.name).and_return('\nJose enter the letter you want to play with it can be: X or: O =>')
  end

  context 'when #enter_name#' do
    it 'returns the first letter in uppercase' do
      player.enter_name
      expect(player.name).to start_with('J')
    end

    it 'retun name' do
      player.enter_name
      expect(player.name).to eq('Jose')
    end

    it 'if the name field is empty' do
      expect(player).to receive(:gets).and_return('', ' ', 'joe')
      expect(player).to receive(:enter_name).and_call_original.exactly(3).times
      player.enter_name
      expect(player.name).to eq('Joe')
    end
  end

  context 'when #coose_letter' do
    it 'x to play' do
      expect(player).to receive(:gets).and_return('x')
      player.choose_letter
      expect(player.letter).to eq('x')
    end

    it 'o to play' do
      expect(player).to receive(:gets).and_return('o')
      player.choose_letter
      expect(player.letter).to eq('o')
    end

    it 'enter it en uppercase' do
      expect(player).to receive(:gets).and_return('X')
      player.choose_letter
      expect(player.letter).to eq('x')
    end

    it 'invalid letter' do
      allow(player).to receive(:gets).and_return('j', 'f', 'X')
      expect(player).to receive(:choose_letter).and_call_original.exactly(3).times
      player.choose_letter
      expect(player.letter).to eq('x')
    end
  end
end
