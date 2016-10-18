module Chess
  module Piece
    class Rook < Base
      def valid_moves
        valid_moves_north +
          valid_moves_south +
          valid_moves_east +
          valid_moves_west
      end

      # Explore North
      def valid_moves_north
        results = []
        rowptr = @position.row
        colptr = @position.col
        while rowptr < @board.height - 1
          rowptr += 1
          other = @board.fetch([rowptr, colptr]).piece
          break if other && other.color == @color
          results << Position.normalize([rowptr, colptr])
          break if other && other.color != @color
        end
        results
      end
      private :valid_moves_north

      # Explore South
      def valid_moves_south
        results = []
        rowptr = @position.row
        colptr = @position.col
        while rowptr > 0
          rowptr -= 1
          other = @board.fetch([rowptr, colptr]).piece
          break if other && other.color == @color
          results << Position.normalize([rowptr, colptr])
          break if other && other.color != @color
        end
        results
      end
      private :valid_moves_south

      # Explore East
      def valid_moves_east
        results = []
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
      private :valid_moves_east

      # Explore West
      def valid_moves_west
        results = []
        rowptr = @position.row
        colptr = @position.col
        while colptr > 0
          colptr -= 1
          other = @board.fetch([rowptr, colptr]).piece
          break if other && other.color == @color
          results << Position.normalize([rowptr, colptr])
          break if other && other.color != @color
        end
        results
      end
      private :valid_moves_west
    end
  end
end
