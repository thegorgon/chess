require 'spec_helper'

describe Chess::Cell do
  let(:cell) { described_class.new('a1') }
  let(:board) { Chess::Board.new }
  let(:piece) { Chess::Piece::Pawn.new(:white, board) }

  describe '#place!' do
    it 'sets a piece' do
      expect(cell.piece).to be_nil
      cell.place!(piece)
      expect(cell.piece).to eq piece
    end
  end

  describe '#piece?' do
    context 'an empty cell' do
      it 'is false' do
        expect(cell.piece?).to be_falsey
      end
    end

    context 'a full cell' do
      before { cell.place!(piece) }

      it 'is true' do
        expect(cell.piece?).to be_truthy
      end
    end
  end

  describe '#empty?' do
    context 'an empty cell' do
      it 'is true' do
        expect(cell).to be_empty
      end
    end

    context 'a full cell' do
      before { cell.place!(piece) }

      it 'is false' do
        expect(cell).to_not be_empty
      end
    end
  end

  describe '#clear!' do
    before { cell.place!(piece) }

    it 'resets the piece' do
      expect(cell.piece?).to be_truthy
      cell.clear!
      expect(cell.piece?).to be_falsey
    end
  end
end
