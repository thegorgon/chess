require 'spec_helper'

describe Chess::Piece::King do
  let(:color) { Chess::COLORS.white }
  let(:board) { Chess::Board.new }
  let(:king) { Chess::Piece::King.new(color, board) }

  describe '#valid_moves' do
    context 'at a base rank, with nothing in the way' do
      before { board.place!(king, 'e1') }

      it 'is in directions north, west and east in the board' do
        expect(king.valid_moves).to match_positions %w(d1 d2 e2 f2 f1)
      end
    end

    context 'at a base rank, with pawns in the way to the north' do
      let(:d2_pawn) { Chess::Piece::Pawn.new(color, board) }
      let(:e2_pawn) { Chess::Piece::Pawn.new(color, board) }
      let(:f2_pawn) { Chess::Piece::Pawn.new(color, board) }
      before { board.place!(king, 'e1') }
      before { board.place!(d2_pawn, 'd2') }
      before { board.place!(e2_pawn, 'e2') }
      before { board.place!(f2_pawn, 'f2') }

      it 'is only to the west and east' do
        expect(king.valid_moves).to match_positions %w(d1 f1)
      end
    end

    context 'at a base rank, with pawns in the way to the north and a queen and bishop' do
      let(:d2_pawn) { Chess::Piece::Pawn.new(color, board) }
      let(:e2_pawn) { Chess::Piece::Pawn.new(color, board) }
      let(:f2_pawn) { Chess::Piece::Pawn.new(color, board) }
      let(:queen) { Chess::Piece::Queen.new(color, board) }
      let(:f1_bishop) { Chess::Piece::Bishop.new(color, board) }
      before { board.place!(king, 'e1') }
      before { board.place!(d2_pawn, 'd2') }
      before { board.place!(e2_pawn, 'e2') }
      before { board.place!(f2_pawn, 'f2') }
      before { board.place!(queen, 'd1') }
      before { board.place!(f1_bishop, 'f1') }

      it 'is empty' do
        expect(king.valid_moves).to be_empty
      end
    end

    context 'in the middle of the board, with nothing else on the board' do
      before { board.place!(king, 'd4') }

      it 'is in all directions' do
        expect(king.valid_moves).to match_positions %w(c3 d3 e3 e4 e5 d5 c5 c4)
      end
    end
  end
end
