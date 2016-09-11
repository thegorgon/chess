module Chess
  module Piece
    class Rook < Base
      def valid_moves
        results = []
        rowptr = @row
        colptr = @col
        while rowptr > 0
          rowptr -= 1
          other = @board.piece_at(rowptr, colptr)
          break if other && other.color == @color
          results << [rowptr, colptr]
        end

        rowptr = @row
        colptr = @col
        while rowptr > 0 && colptr < @board.width - 1
          rowptr -= 1
          colptr += 1
          other = @board.piece_at(rowptr, colptr)
          break if other && other.color == @color
          results << [rowptr, colptr]
        end

        rowptr = @row
        colptr = @col
        while rowptr < @board.height - 1 && colptr < @board.width - 1
          rowptr += 1
          colptr += 1
          other = @board.piece_at(rowptr, colptr)
          break if other && other.color == @color
          results << [rowptr, colptr]
        end

        rowptr = @row
        colptr = @col
        while rowptr < @board.height - 1 && colptr > 0
          rowptr += 1
          colptr -= 1
          other = @board.piece_at(rowptr, colptr)
          break if other && other.color == @color
          results << [rowptr, colptr]
        end

        results
      end
    end
  end
end
