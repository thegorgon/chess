require 'spec_helper'

describe Chess::Piece::Queen do
  let(:color) { Chess::COLORS.white }
  let(:board) { Chess::Board.new }
  let(:queen) { Chess::Piece::Queen.new(color, board) }

  describe '#valid_moves' do
    context 'at a base rank, with nothing in the way' do
      before { board.place!(queen, 'd1') }

      it 'is in every direction' do
        expect(queen.valid_moves).to match_positions %w(
          a1 b1 c1 e1 f1 g1 h1 c2 b3 a4 e2
          f3 g4 h5 d2 d3 d4 d5 d6 d7 d8
        )
      end
    end

    context 'at a base rank, with an opposing pawn to the north' do
      let(:d4_opposing_pawn) { Chess::Piece::Pawn.new(Chess::COLORS.black, board) }
      before { board.place!(d4_opposing_pawn, 'd4') }
      before { board.place!(queen, 'd1') }

      it 'is in every direction' do
        expect(queen.valid_moves).to match_positions %w(
          a1 b1 c1 e1 f1 g1 h1 c2 b3
          a4 e2 f3 g4 h5 d2 d3 d4
        )
      end
    end

    context 'at a base rank, with a pawn to the north' do
      let(:d2_pawn) { Chess::Piece::Pawn.new(color, board) }
      before { board.place!(d2_pawn, 'd2') }
      before { board.place!(queen, 'd1') }

      it 'is in every direction, except north' do
        expect(queen.valid_moves).to match_positions %w(
          a1 b1 c1 e1 f1 g1 h1 c2
          b3 a4 e2 f3 g4 h5
        )
      end
    end

    context 'at a base rank, with a pawn to the north and north west' do
      let(:d2_pawn) { Chess::Piece::Pawn.new(color, board) }
      let(:c2_pawn) { Chess::Piece::Pawn.new(color, board) }
      before { board.place!(d2_pawn, 'd2') }
      before { board.place!(c2_pawn, 'c2') }
      before { board.place!(queen, 'd1') }

      it 'is in every direction, except north and north west' do
        expect(queen.valid_moves).to match_positions %w(a1 b1 c1 e1 f1 g1 h1 e2 f3 g4 h5)
      end
    end

    context 'at a base rank, with a pawn to the north and north east' do
      let(:d2_pawn) { Chess::Piece::Pawn.new(color, board) }
      let(:e2_pawn) { Chess::Piece::Pawn.new(color, board) }
      before { board.place!(d2_pawn, 'd2') }
      before { board.place!(e2_pawn, 'e2') }
      before { board.place!(queen, 'd1') }

      it 'is in every direction, except north and north east' do
        expect(queen.valid_moves).to match_positions %w(a1 b1 c1 e1 f1 g1 h1 c2 b3 a4)
      end
    end

    context 'at a base rank, with classic bishops in place' do
      let(:c1_bishop) { Chess::Piece::Bishop.new(color, board) }
      let(:f1_bishop) { Chess::Piece::Bishop.new(color, board) }
      before { board.place!(c1_bishop, 'c1') }
      before { board.place!(f1_bishop, 'f1') }
      before { board.place!(queen, 'd1') }

      it 'is in every direction, except north and north east' do
        expect(queen.valid_moves).to match_positions %w(
          e1 c2 b3 a4 e2 f3 g4 h5 d2 d3 d4 d5 d6 d7 d8
        )
      end
    end

    context 'in the southwest corner with nothing in the way' do
      before { board.place!(queen, 'a1') }

      it 'is north, west and northwest' do
        expect(queen.valid_moves).to match_positions %w(
          a2 a3 a4 a5 a6 a7 a8 b1 c1 d1 e1
          f1 g1 h1 b2 c3 d4 e5 f6 g7 h8
        )
      end
    end

    context 'in the middle of the board, with nothing in the way' do
      before { board.place!(queen, 'e5') }

      it 'is in every direction' do
        expect(queen.valid_moves).to match_positions %w(
          e1 e2 e3 e4 e6 e7 e8 a5 b5
          c5 d5 f5 g5 h5 d4 c3 b2 a1
          f6 g7 h8 d6 c7 b8 f4 g3 h2
        )
      end
    end

    context 'in the middle of the board, with opposing pieces all around' do
      let(:d6_pawn) { Chess::Piece::Pawn.new(Chess::COLORS.black, board) }
      let(:e6_pawn) { Chess::Piece::Pawn.new(Chess::COLORS.black, board) }
      let(:f6_pawn) { Chess::Piece::Pawn.new(Chess::COLORS.black, board) }
      let(:f5_pawn) { Chess::Piece::Pawn.new(Chess::COLORS.black, board) }
      let(:f4_pawn) { Chess::Piece::Pawn.new(Chess::COLORS.black, board) }
      let(:e4_pawn) { Chess::Piece::Pawn.new(Chess::COLORS.black, board) }
      let(:d4_pawn) { Chess::Piece::Pawn.new(Chess::COLORS.black, board) }
      let(:d5_pawn) { Chess::Piece::Pawn.new(Chess::COLORS.black, board) }
      before { board.place!(queen, 'e5') }
      before { board.place!(d6_pawn, 'd6') }
      before { board.place!(e6_pawn, 'e6') }
      before { board.place!(f6_pawn, 'f6') }
      before { board.place!(f5_pawn, 'f5') }
      before { board.place!(f4_pawn, 'f4') }
      before { board.place!(e4_pawn, 'e4') }
      before { board.place!(d4_pawn, 'd4') }
      before { board.place!(d5_pawn, 'd5') }

      it 'is in every direction' do
        expect(queen.valid_moves).to match_positions %w(d6 e6 f6 f5 f4 e4 d4 d5)
      end
    end

    context 'in the middle of the board, with partner pieces all around' do
      let(:d6_pawn) { Chess::Piece::Pawn.new(color, board) }
      let(:e6_pawn) { Chess::Piece::Pawn.new(color, board) }
      let(:f6_pawn) { Chess::Piece::Pawn.new(color, board) }
      let(:f5_pawn) { Chess::Piece::Pawn.new(color, board) }
      let(:f4_pawn) { Chess::Piece::Pawn.new(color, board) }
      let(:e4_pawn) { Chess::Piece::Pawn.new(color, board) }
      let(:d4_pawn) { Chess::Piece::Pawn.new(color, board) }
      let(:d5_pawn) { Chess::Piece::Pawn.new(color, board) }
      before { board.place!(queen, 'e5') }
      before { board.place!(d6_pawn, 'd6') }
      before { board.place!(e6_pawn, 'e6') }
      before { board.place!(f6_pawn, 'f6') }
      before { board.place!(f5_pawn, 'f5') }
      before { board.place!(f4_pawn, 'f4') }
      before { board.place!(e4_pawn, 'e4') }
      before { board.place!(d4_pawn, 'd4') }
      before { board.place!(d5_pawn, 'd5') }

      it 'is in every direction' do
        expect(queen.valid_moves).to be_empty
      end
    end
  end
end
