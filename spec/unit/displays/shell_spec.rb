require 'spec_helper'

describe Chess::Display::Shell do
  let(:out) { double('stdout') }
  let(:display) { Chess::Display::Shell.new(out) }

  describe '#clear!' do
    it 'prints the clear character' do
      expect(out).to receive(:print).with("\e[H\e[2J")
      display.clear!
    end
  end

  describe '#say' do
    it 'prints a message and a newline' do
      expect(out).to receive(:print).with('message')
      expect(out).to receive(:print).with("\n")
      display.say('message')
    end
  end
end
