require 'spec_helper'

describe Chess::Piece::Rook do
  let(:color) { Chess::COLORS.white }
  let(:board) { Chess::Board.new }
  let(:rook) { Chess::Piece::Rook.new(color, board) }

  describe '#valid_moves' do
    context 'in the SW corner with nothing in the way' do
      before { board.place!(rook, 'a1') }

      it 'is forward and to the right' do
        expect(rook.valid_moves).to match_positions %w(a2 a3 a4 a5 a6 a7 a8 b1 c1 d1 e1 f1 g1 h1)
      end
    end

    context 'in the SW corner with a pawn blocking ahead' do
      let(:a2_pawn) { Chess::Piece::Pawn.new(color, board) }
      before { board.place!(rook, 'a1') }
      before { board.place!(a2_pawn, 'a2') }

      it 'is to the right' do
        expect(rook.valid_moves).to match_positions %w(b1 c1 d1 e1 f1 g1 h1)
      end
    end

    context 'in the SW corner with a pawn blocking ahead and a knight to the right' do
      let(:a2_pawn) { Chess::Piece::Pawn.new(color, board) }
      let(:knight) { Chess::Piece::Knight.new(color, board) }
      before { board.place!(rook, 'a1') }
      before { board.place!(a2_pawn, 'a2') }
      before { board.place!(knight, 'b1') }

      it 'is to the right' do
        expect(rook.valid_moves).to be_empty
      end
    end

    context 'in the middle of the board with nothing in the way' do
      before { board.place!(rook, 'd4') }

      it 'is in all directions' do
        expect(rook.valid_moves).to match_positions %w(a4 b4 c4 e4 f4 g4 h4 d1 d2 d3 d5 d6 d7 d8)
      end
    end

    context 'in the middle of the board with another piece blocking one direction' do
      let(:pawn) { Chess::Piece::Pawn.new(color, board) }
      before { board.place!(rook, 'd4') }
      before { board.place!(pawn, 'f4') }

      it 'is in all directions except the blocked one' do
        expect(rook.valid_moves).to match_positions %w(a4 b4 c4 e4 d1 d2 d3 d5 d6 d7 d8)
      end
    end

    context 'in the middle of the board with an opposing piece blocking one direction' do
      let(:pawn) { Chess::Piece::Pawn.new(Chess::COLORS.black, board) }
      before { board.place!(rook, 'd4') }
      before { board.place!(pawn, 'f4') }

      it 'is in all directions except the blocked one, but includes the opposing piece' do
        expect(rook.valid_moves).to match_positions %w(a4 b4 c4 e4 f4 d1 d2 d3 d5 d6 d7 d8)
      end
    end
  end
end
