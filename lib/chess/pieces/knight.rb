module Chess
  module Piece
    class Knight < Base
      def valid_moves
        [
          [@position.row - 2, @position.col + 1],
          [@position.row - 2, @position.col - 1],
          [@position.row + 2, @position.col + 1],
          [@position.row + 2, @position.col - 1],
          [@position.row + 1, @position.col + 2],
          [@position.row - 1, @position.col + 2],
          [@position.row + 1, @position.col - 2],
          [@position.row - 1, @position.col - 2],
        ].inject([]) do |memo, (row, col)|
          if (0..7).include?(row) && (0..7).include?(col)
            other = @board.fetch([row, col]).piece
            if other.nil? || other.color != @color
              memo << Position.normalize([row, col])
            end
          end
          memo
        end
      end
    end
  end
end
