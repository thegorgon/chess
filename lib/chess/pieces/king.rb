module Chess
  module Piece
    # Defines a king with it's valid moves.
    class King < Base
      def valid_moves
        [
          [@position.row - 1, @position.col - 1],
          [@position.row - 1, @position.col],
          [@position.row - 1, @position.col + 1],
          [@position.row, @position.col + 1],
          [@position.row, @position.col - 1],
          [@position.row + 1, @position.col - 1],
          [@position.row + 1, @position.col],
          [@position.row + 1, @position.col + 1]
        ].each_with_object([]) do |(row, col), memo|
          next unless (0..@board.height - 1).cover?(row) && (0..@board.width - 1).cover?(col)
          check_position = Position.normalize([row, col])
          other = @board.fetch(check_position).piece
          memo << check_position if other.nil? || other.color != @color
        end
      end
    end
  end
end
