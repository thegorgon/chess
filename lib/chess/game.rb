module Chess
  class Game
    attr_reader :board, :playing

    def initialize
      @board = Board.new
      @playing = :white
      reset_board!
    end

    def not_playing
      @playing == :white ? :black : :white
    end

    def finished?
      false
    end

    def play!(move)
      piece = @board.fetch(move.start_position).piece
      return MoveResult::EMPTY_CELL if piece.nil?
      return MoveResult::INVALID_COLOR if piece.color != @playing
      return MoveResult::INVALID_MOVE unless piece.valid_moves.include?(move.end_position)
      @board.move!(move)
      @playing = not_playing
      MoveResult::SUCCESS
    end

    def reset_board!
      @board.clear!
      {
        white: { pawns: 2, pieces: 1 },
        black: { pawns: 7, pieces: 8 }
      }.each do |color, rows|
        rows.each do |type, row|
          if type == :pawns
            place_pawn_row!(row, color)
          else
            place_pieces_row!(row, color)
          end
        end
      end
    end

    def place_pieces_row!(row, color)
      {
        a: Piece::Rook,
        b: Piece::Knight,
        c: Piece::Bishop,
        d: Piece::Queen,
        e: Piece::King,
        f: Piece::Bishop,
        g: Piece::Knight,
        h: Piece::Rook
      }.each do |col, klass|
        piece = klass.new(color, @board)
        @board.place!(piece, "#{col}#{row}")
      end
    end
    private :place_pieces_row!

    def place_pawn_row!(row, color)
      ('a'..'h').each do |col|
        piece = Piece::Pawn.new(color, @board)
        @board.place!(piece, "#{col}#{row}")
      end
    end
    private :place_pawn_row!
  end
end
