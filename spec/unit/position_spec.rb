require 'spec_helper'

describe Chess::Position do
  describe '.from_id' do
    {
      a1: [0, 0],
      b1: [0, 1],
      a2: [1, 0],
      h8: [7, 7],
      h7: [6, 7],
      g8: [7, 6]
    }.each do |id, (row, col)|
      context id.to_s do
        it "sets row to #{row}" do
          expect(described_class.from_id(id).row).to eq row
        end

        it "sets col to #{col}" do
          expect(described_class.from_id(id).col).to eq col
        end

        it "sets #{id} to #{id}" do
          expect(described_class.from_id(id).id).to eq id.to_s
        end
      end
    end

    it 'blows up with an invalid column' do
      expect { described_class.from_id('i1') }.to raise_error 'Invalid column position: i1'
    end

    it 'blows up with a row that is too big' do
      expect { described_class.from_id('a9') }.to raise_error 'Invalid row position: a9'
    end

    it 'blows up with a row that is too small' do
      expect { described_class.from_id('a0') }.to raise_error 'Invalid row position: a0'
    end

    it 'blows up with an invalid string' do
      expect { described_class.from_id('fart nuggets') }.to raise_error(
        'Invalid position: fart nuggets'
      )
    end
  end

  describe '.from_indices' do
    {
      [0, 0] => 'a1',
      [0, 1] => 'b1',
      [1, 0] => 'a2',
      [7, 7] => 'h8',
      [6, 7] => 'h7',
      [7, 6] => 'g8'
    }.each do |(row, col), id|
      context "#{row},#{col}" do
        it "sets row to #{row}" do
          expect(described_class.from_indices(row: row, col: col).row).to eq row
        end

        it "sets col to #{col}" do
          expect(described_class.from_indices(row: row, col: col).col).to eq col
        end

        it "sets #{id} to #{id}" do
          expect(described_class.from_indices(row: row, col: col).id).to eq id
        end
      end
    end

    it 'blows up with a row number that is too big' do
      expect { described_class.from_indices(row: 9, col: 0) }.to raise_error(
        'Invalid row position: 9'
      )
    end

    it 'blows up with a row number that is too small' do
      expect { described_class.from_indices(row: -1, col: 0) }.to raise_error(
        'Invalid row position: -1'
      )
    end

    it 'blows up with a column number that is too big' do
      expect { described_class.from_indices(row: 0, col: 9) }.to raise_error(
        'Invalid column position: 9'
      )
    end

    it 'blows up with a column number that is too small' do
      expect { described_class.from_indices(row: 0, col: -1) }.to raise_error(
        'Invalid column position: -1'
      )
    end
  end

  describe '.from_array' do
    {
      [0, 0] => 'a1',
      [0, 1] => 'b1',
      [1, 0] => 'a2',
      [7, 7] => 'h8',
      [6, 7] => 'h7',
      [7, 6] => 'g8'
    }.each do |(row, col), id|
      context "#{row},#{col}" do
        it "sets row to #{row}" do
          expect(described_class.from_array([row, col]).row).to eq row
        end

        it "sets col to #{col}" do
          expect(described_class.from_array([row, col]).col).to eq col
        end

        it "sets #{id} to #{id}" do
          expect(described_class.from_array([row, col]).id).to eq id
        end
      end
    end

    it 'blows up with a row number that is too big' do
      expect { described_class.from_array([9, 0]) }.to(
        raise_error 'Invalid row position: 9'
      )
    end

    it 'blows up with a row number that is too small' do
      expect { described_class.from_array([-1, 0]) }.to(
        raise_error 'Invalid row position: -1'
      )
    end

    it 'blows up with a column number that is too big' do
      expect { described_class.from_array([0, 9]) }.to(
        raise_error 'Invalid column position: 9'
      )
    end

    it 'blows up with a column number that is too small' do
      expect { described_class.from_array([0, -1]) }.to(
        raise_error 'Invalid column position: -1'
      )
    end

    it 'blows up with an array that is too big' do
      expect { described_class.from_array([0, 0, 0]) }.to(
        raise_error 'Invalid array: [0, 0, 0]'
      )
    end

    it 'blows up with an array that is too small' do
      expect { described_class.from_array([0]) }.to(
        raise_error 'Invalid array: [0]'
      )
    end
  end

  describe '.normalize' do
    it 'keeps positions as positions' do
      expect(described_class.normalize(described_class.from_id('a1'))).to eq(
        described_class.from_id('a1')
      )
    end

    it 'turns strings into positions' do
      expect(described_class.normalize('a1')).to eq described_class.from_id('a1')
    end

    it 'turns hashes into positions' do
      expect(described_class.normalize(row: 0, col: 0)).to eq described_class.from_id('a1')
    end

    it 'turns arrays into positions' do
      expect(described_class.normalize([0, 0])).to eq described_class.from_id('a1')
    end

    it 'blows up with something else' do
      expect { described_class.normalize(4) }.to raise_error 'Invalid position: 4'
    end
  end

  describe '.new' do
    it 'is private' do
      expect { described_class.new(row: 1, col: 1, id: 'a1') }.to raise_error NoMethodError
    end
  end

  describe '#==' do
    context 'with an equal position' do
      it 'is true' do
        expect(
          described_class.from_indices(row: 0, col: 0) ==
            described_class.from_indices(row: 0, col: 0)
        ).to eq true
      end
    end

    context 'with an equivalent string' do
      it 'is true' do
        expect(described_class.from_indices(row: 0, col: 0) == 'a1').to eq true
      end
    end

    context 'with an equivalent array' do
      it 'is true' do
        expect(described_class.from_indices(row: 0, col: 0) == [0, 0]).to eq true
      end
    end

    context 'with an equivalent hash' do
      it 'is false' do
        expect(described_class.from_indices(row: 0, col: 0) == { row: 0, col: 0 }).to eq true
      end
    end

    context 'with a hash with invalid keys' do
      it 'is false' do
        expect(
          described_class.from_indices(row: 0, col: 0) == { foo: 0, bar: 0 }
        ).to eq false
      end
    end

    context 'with a hash with extra keys' do
      it 'is false' do
        expect(
          described_class.from_indices(row: 0, col: 0) == { row: 0, col: 0, foo: 0 }
        ).to eq false
      end
    end

    context 'with an array that is not the right length' do
      it 'is false' do
        expect(described_class.from_indices(row: 0, col: 0) == [0, 1, 2]).to eq false
      end
    end

    context 'with a string that is not the right length' do
      it 'is false' do
        expect(described_class.from_indices(row: 0, col: 0) == 'abc').to eq false
      end
    end

    context 'with an invalid string' do
      it 'is false' do
        expect(described_class.from_indices(row: 0, col: 0) == '00').to eq false
      end
    end

    context 'with an invalid array' do
      it 'is false' do
        expect(described_class.from_indices(row: 0, col: 0) == [-1, -2]).to eq false
      end
    end

    context 'with something else' do
      it 'is false' do
        expect(described_class.from_indices(row: 0, col: 0) == 17).to eq false
      end
    end
  end
end
