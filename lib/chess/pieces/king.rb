module Chess
  module Piece
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
          [@position.row + 1, @position.col + 1],
        ].inject([]) do |memo, (row, col)|
          if (0..@board.height-1).include?(row) && (0..@board.width-1).include?(col)
            check_position = Position.normalize([row, col])
            other = @board.fetch(check_position).piece
            if other.nil? || other.color != @color
              memo << check_position
            end
          end
          memo
        end
      end
    end
  end
end
