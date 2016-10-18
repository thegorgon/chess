require 'spec_helper'

describe Chess::Piece::Knight do
  let(:color) { Chess::COLORS.white }
  let(:board) { Chess::Board.new }
  let(:knight) { Chess::Piece::Knight.new(color, board) }

  describe '#valid_moves' do
    context 'in the middle of the board' do
      before { board.place!(knight, 'e5') }

      it 'is all 8 positions' do
        expect(knight.valid_moves).to match_positions %w(f7 d7 c6 c4 d3 f3 g6 g4)
      end
    end

    context 'in the middle of the board, with another piece on one of the squares' do
      let(:bishop) { Chess::Piece::Pawn.new(color, board) }
      before { board.place!(knight, 'e5') }
      before { board.place!(bishop, 'f7') }

      it 'is all 8 positions except the one' do
        expect(knight.valid_moves).to match_positions %w(d7 c6 c4 d3 f3 g6 g4)
      end
    end

    context 'in the middle of the board, with an opposing piece on one of the squares' do
      let(:bishop) { Chess::Piece::Pawn.new(Chess::COLORS.black, board) }
      before { board.place!(knight, 'e5') }
      before { board.place!(bishop, 'f7') }

      it 'is all 8 positions except the one' do
        expect(knight.valid_moves).to match_positions %w(f7 d7 c6 c4 d3 f3 g6 g4)
      end
    end

    context 'in the starting SW side of the board' do
      before { board.place!(knight, 'b1') }

      it 'is only 3 positions' do
        expect(knight.valid_moves).to match_positions %w(a3 c3 d2)
      end
    end

    context 'in the starting NE side of the board' do
      let(:color) { Chess::COLORS.black }
      before { board.place!(knight, 'g8') }

      it 'is only 3 positions' do
        expect(knight.valid_moves).to match_positions %w(f6 h6 e7)
      end
    end
  end
end
