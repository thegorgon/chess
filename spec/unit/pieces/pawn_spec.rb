require 'spec_helper'

describe Chess::Piece::Pawn do
  let(:color) { Chess::COLORS.white }
  let(:board) { Chess::Board.new }
  let(:pawn) { Chess::Piece::Pawn.new(color, board) }

  describe '#valid_moves' do
    context 'white starting position' do
      let(:color) { Chess::COLORS.white }
      before { board.place!(pawn, 'e2') }

      it 'is 1 move forward and 2 moves forward' do
        expect(pawn.valid_moves).to match_positions %w(e3 e4)
      end
    end

    context 'black starting position' do
      let(:color) { Chess::COLORS.black }
      before { board.place!(pawn, 'e7') }

      it 'is 1 move forward and 2 moves forward' do
        expect(pawn.valid_moves).to match_positions %w(e6 e5)
      end
    end

    context 'white, with an opposing pawn forward on the left' do
      let(:color) { Chess::COLORS.white }
      let(:other) { Chess::Piece::Pawn.new(Chess::COLORS.black, board) }
      before { board.place!(pawn, 'e2') }
      before { board.place!(other, 'd4') }
      before { board.move!('e2-e3') }

      it 'is 1 move forward and attacking the opposing pawn' do
        expect(pawn.valid_moves).to match_positions %w(e4 d4)
      end
    end

    context 'black, with an opposing pawn forward on the left' do
      let(:color) { Chess::COLORS.black }
      let(:other) { Chess::Piece::Pawn.new(Chess::COLORS.white, board) }
      before { board.place!(pawn, 'e7') }
      before { board.place!(other, 'f5') }
      before { board.move!('e7-e6') }

      it 'is 1 move forward and attacking the opposing pawn' do
        expect(pawn.valid_moves).to match_positions %w(e5 f5)
      end
    end

    context 'white, with an opposing pawn forward on the right' do
      let(:color) { Chess::COLORS.white }
      let(:other) { Chess::Piece::Pawn.new(Chess::COLORS.black, board) }
      before { board.place!(pawn, 'e2') }
      before { board.place!(other, 'f4') }
      before { board.move!('e2-e3') }

      it 'is 1 move forward and attacking the opposing pawn' do
        expect(pawn.valid_moves).to match_positions %w(e4 f4)
      end
    end

    context 'black, with an opposing pawn forward on the right' do
      let(:color) { Chess::COLORS.black }
      let(:other) { Chess::Piece::Pawn.new(Chess::COLORS.white, board) }
      before { board.place!(pawn, 'e7') }
      before { board.place!(other, 'd5') }
      before { board.move!('e7-e6') }

      it 'is 1 move forward and attacking the opposing pawn' do
        expect(pawn.valid_moves).to match_positions %w(e5 d5)
      end
    end

    context 'white, with an opposing pawn forward on the right and left' do
      let(:color) { Chess::COLORS.white }
      let(:other1) { Chess::Piece::Pawn.new(Chess::COLORS.black, board) }
      let(:other2) { Chess::Piece::Pawn.new(Chess::COLORS.black, board) }
      before { board.place!(pawn, 'e2') }
      before { board.place!(other1, 'd4') }
      before { board.place!(other2, 'f4') }
      before { board.move!('e2-e3') }

      it 'is 1 move forward and attacking the opposing pawns' do
        expect(pawn.valid_moves).to match_positions %w(e4 d4 f4)
      end
    end

    context 'black, with an opposing pawn forward on the right and left' do
      let(:color) { Chess::COLORS.black }
      let(:other1) { Chess::Piece::Pawn.new(Chess::COLORS.white, board) }
      let(:other2) { Chess::Piece::Pawn.new(Chess::COLORS.white, board) }
      before { board.place!(pawn, 'e7') }
      before { board.place!(other1, 'f5') }
      before { board.place!(other2, 'd5') }
      before { board.move!('e7-e6') }

      it 'is 1 move forward and attacking the opposing pawns' do
        expect(pawn.valid_moves).to match_positions %w(e5 d5 f5)
      end
    end

    context 'white, with a white pawn forward on the left' do
      let(:color) { Chess::COLORS.white }
      let(:other) { Chess::Piece::Pawn.new(Chess::COLORS.white, board) }
      before { board.place!(pawn, 'e2') }
      before { board.place!(other, 'd4') }
      before { board.move!('e2-e3') }

      it 'is 1 move forward' do
        expect(pawn.valid_moves).to match_positions %w(e4)
      end
    end

    context 'with a pawn right in front and none on the sides' do
      let(:other) { Chess::Piece::Pawn.new(Chess::COLORS.white, board) }
      before { board.place!(pawn, 'e2') }
      before { board.place!(other, 'e7') }
      before { board.move!('e2-e4') }
      before { board.move!('e7-e5') }

      it 'is empty' do
        expect(pawn.valid_moves).to be_empty
      end
    end
  end
end
