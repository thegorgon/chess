module Chess
  module Piece
    class Bishop < Base
      def valid_moves
        results = []

        # Explore SW diagonal
        rowptr = @position.row
        colptr = @position.col
        while rowptr > 0 && colptr > 0
          rowptr -= 1
          colptr -= 1
          other = @board.fetch([rowptr, colptr]).piece
          break if other && other.color == @position.color
          results << Position.normalize([rowptr, colptr])
          break if other && other.color != color
        end

        # Explore SE diagonal
        rowptr = @position.row
        colptr = @position.col
        while rowptr > 0 && colptr < @board.width - 1
          rowptr -= 1
          colptr += 1
          other = @board.fetch(rowptr, colptr).piece
          break if other && other.color == @position.color
          results << Position.normalize([rowptr, colptr])
          break if other && other.color != color
        end

        # Explore NE diagonal
        rowptr = @position.row
        colptr = @position.col
        while rowptr < @board.height - 1 && colptr < @board.width - 1
          rowptr += 1
          colptr += 1
          other = @board.fetch(rowptr, colptr).piece
          break if other && other.color == @position.color
          results << Position.normalize([rowptr, colptr])
          break if other && other.color != color
        end

        # Explore NW diagonal
        rowptr = @position.row
        colptr = @position.col
        while rowptr < @board.height - 1 && colptr > 0
          rowptr += 1
          colptr -= 1
          other = @board.fetch(rowptr, colptr).piece
          break if other && other.color == @position.color
          results << Position.normalize([rowptr, colptr])
          break if other && other.color != color
        end

        results
      end
    end
  end
end
