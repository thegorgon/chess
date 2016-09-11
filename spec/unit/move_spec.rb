require 'spec_helper'

describe Chess::Move do
  describe '.new' do
    it 'is private' do
      expect { described_class.new(row: 1, col: 1, id: 'a1') }.to raise_error NoMethodError
    end
  end

  describe '.normalize' do
    let(:move) { described_class.from_string('e2-e3') }

    it 'keeps moves as moves' do
      expect(described_class.normalize(move)).to eq move
    end

    it 'turns strings into positions' do
      expect(
        described_class.normalize("#{move.start_position.id}-#{move.end_position.id}")
      ).to eq move
    end

    it 'turns hashes into moves' do
      expect(
        described_class.normalize(start: move.start_position, end: move.end_position)
      ).to eq move
    end

    it 'turns arrays into moves' do
      expect(
        described_class.normalize([move.start_position, move.end_position])
      ).to eq move
    end

    it 'blows up with something else' do
      expect { described_class.normalize(4) }.to raise_error 'Invalid move: 4'
    end
  end

  describe '.from_string' do
    it 'turns a string into a move' do
      expect(described_class.from_string('a1-a2')).to eq(
        described_class.from_hash(start: 'a1', end: 'a2')
      )
    end

    it 'blows up with an invalid string' do
      expect { described_class.from_string('foo') }
        .to raise_error(/Invalid move string/)
    end
  end

  describe '.from_hash' do
    it 'turns a hash into a move' do
      expect(described_class.from_hash(start: 'a1', end: 'a2')).to eq(
        described_class.from_array(%w(a1 a2))
      )
    end

    it 'blows up with a hash without the right keys' do
      expect { described_class.from_hash(foo: 'bar') }
        .to raise_error(/Invalid move hash/)
    end

    it 'blows up with a hash with extra keys' do
      expect { described_class.from_hash(start: 'a1', end: 'a2', foo: 'bar') }
        .to raise_error(/Invalid move hash/)
    end
  end

  describe '.from_array' do
    it 'turns a string into a move' do
      expect(described_class.from_array(%w(a1 a2))).to eq(
        described_class.from_string('a1-a2')
      )
    end

    it 'blows up with an array that is too short' do
      expect { described_class.from_array(%w(a1)) }
        .to raise_error(/Invalid move array/)
    end

    it 'blows up with an array that is too long' do
      expect { described_class.from_array(%w(a1 a2 a3)) }
        .to raise_error(/Invalid move array/)
    end
  end

  describe '#==' do
    let(:move) { described_class.from_string('a1-b7') }

    context 'when the other is the same object' do
      it 'is true' do
        expect(move == move).to eq true
      end
    end

    context 'when the other is the same move' do
      it 'is true' do
        expect(move == described_class.from_string('a1-b7')).to eq true
      end
    end

    context 'when the other is a move from a different position' do
      it 'is false' do
        expect(move == described_class.from_string('a2-b7')).to eq false
      end
    end

    context 'when the other is a move to a different position' do
      it 'is false' do
        expect(move == described_class.from_string('a1-b6')).to eq false
      end
    end

    context 'when the other is a completely different move' do
      it 'is false' do
        expect(move == described_class.from_string('b3-f4')).to eq false
      end
    end

    context 'when the other is not a move' do
      it 'is false' do
        expect(move == 1).to eq false
      end
    end
  end
end
