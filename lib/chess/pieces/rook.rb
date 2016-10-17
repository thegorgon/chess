module Chess
  module Piece
    class Rook < Base
      def valid_moves
        results = []

        # Explore South
        rowptr = @position.row
        colptr = @position.col
        while rowptr > 0
          rowptr -= 1
          other = @board.fetch([rowptr, colptr]).piece
          break if other && other.color == @color
          results << Position.normalize([rowptr, colptr])
          break if other && other.color != @color
        end

        # Explore North
        rowptr = @position.row
        colptr = @position.col
        while rowptr < @board.height - 1
          rowptr += 1
          other = @board.fetch([rowptr, colptr]).piece
          break if other && other.color == @color
          results << Position.normalize([rowptr, colptr])
          break if other && other.color != @color
        end

        # Explore West
        rowptr = @position.row
        colptr = @position.col
        while colptr > 0
          colptr -= 1
          other = @board.fetch([rowptr, colptr]).piece
          break if other && other.color == @color
          results << Position.normalize([rowptr, colptr])
          break if other && other.color != @color
        end

        # Explore East
        rowptr = @position.row
        colptr = @position.col
        while colptr < @board.width - 1
          colptr += 1
          other = @board.fetch([rowptr, colptr]).piece
          break if other && other.color == @color
          results << Position.normalize([rowptr, colptr])
          break if other && other.color != @color
        end

        results
      end
    end
  end
end
