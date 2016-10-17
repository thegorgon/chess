require 'spec_helper'

describe Chess::Piece::Bishop do
  let(:color) { Chess::COLORS.white }
  let(:board) { Chess::Board.new }
  let(:bishop) { Chess::Piece::Bishop.new(color, board) }

  describe '#valid_moves' do
    context 'with nothing in the way' do
      before { board.place!(bishop, 'c1') }

      it 'is forward to the left and right' do
        expect(bishop.valid_moves).to match_positions %w(b2 a3 d2 e3 f4 g5 h6)
      end
    end

    context 'with 1 pawn blocking on the left' do
      let(:b2_pawn) { Chess::Piece::Pawn.new(color, board) }
      before { board.place!(bishop, 'c1') }
      before { board.place!(b2_pawn, 'b2') }

      it 'is forward to the right' do
        expect(bishop.valid_moves).to match_positions %w(d2 e3 f4 g5 h6)
      end
    end

    context 'in the standard initial position, with 2 pawns blocking on the left and right' do
      let(:b2_pawn) { Chess::Piece::Pawn.new(color, board) }
      let(:d2_pawn) { Chess::Piece::Pawn.new(color, board) }
      before { board.place!(bishop, 'c1') }
      before { board.place!(b2_pawn, 'b2') }
      before { board.place!(d2_pawn, 'd2') }

      it 'is empty' do
        expect(bishop.valid_moves).to be_empty
      end
    end

    context 'in the middle of the board, with nothing blocking' do
      before { board.place!(bishop, 'd3') }

      it 'is forward and backward in all directions' do
        expect(bishop.valid_moves).to match_positions %w(c2 b1 c4 b5 a6 e2 f1 e4 f5 g6 h7)
      end
    end

    context 'in the middle of the board, with an opponent blocking one direction' do
      let(:other) { Chess::Piece::Bishop.new(Chess::COLORS.black, board) }
      before { board.place!(bishop, 'd3') }
      before { board.place!(other, 'e4') }

      it 'is forward and backward in all directions' do
        expect(bishop.valid_moves).to match_positions %w(c2 b1 c4 b5 a6 e2 f1 e4)
      end
    end

    context 'in the middle of the board, with another piece blocking one direction' do
      let(:other) { Chess::Piece::Bishop.new(Chess::COLORS.white, board) }
      before { board.place!(bishop, 'd3') }
      before { board.place!(other, 'e4') }

      it 'is forward and backward in all directions' do
        expect(bishop.valid_moves).to match_positions %w(c2 b1 c4 b5 a6 e2 f1)
      end
    end
  end
end
