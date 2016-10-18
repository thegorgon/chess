module Chess
  module Piece
    class Bishop < Base
      def valid_moves
        valid_moves_nw +
          valid_moves_ne +
          valid_moves_sw +
          valid_moves_se
      end

      # Explore NW diagonal
      def valid_moves_nw
        results = []
        rowptr = @position.row
        colptr = @position.col
        while rowptr < @board.height - 1 && colptr > 0
          rowptr += 1
          colptr -= 1
          other = @board.fetch([rowptr, colptr]).piece
          break if other && other.color == @color
          results << Position.normalize([rowptr, colptr])
          break if other && other.color != @color
        end
        results
      end
      private :valid_moves_nw

      # Explore NE diagonal
      def valid_moves_ne
        results = []
        rowptr = @position.row
        colptr = @position.col
        while rowptr < @board.height - 1 && colptr < @board.width - 1
          rowptr += 1
          colptr += 1
          other = @board.fetch([rowptr, colptr]).piece
          break if other && other.color == @color
          results << Position.normalize([rowptr, colptr])
          break if other && other.color != @color
        end
        results
      end
      private :valid_moves_ne

      # Explore SW diagonal
      def valid_moves_sw
        results = []
        rowptr = @position.row
        colptr = @position.col
        while rowptr > 0 && colptr > 0
          rowptr -= 1
          colptr -= 1
          other = @board.fetch([rowptr, colptr]).piece
          break if other && other.color == @color
          results << Position.normalize([rowptr, colptr])
          break if other && other.color != @color
        end
        results
      end
      private :valid_moves_sw

      # Explore SE diagonal
      def valid_moves_se
        results = []
        rowptr = @position.row
        colptr = @position.col
        while rowptr > 0 && colptr < @board.width - 1
          rowptr -= 1
          colptr += 1
          other = @board.fetch([rowptr, colptr]).piece
          break if other && other.color == @color
          results << Position.normalize([rowptr, colptr])
          break if other && other.color != @color
        end
        results
      end
      private :valid_moves_se
    end
  end
end
