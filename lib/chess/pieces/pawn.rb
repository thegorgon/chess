# Defines a pawn with it's valid moves.
# TODO - en passant and promotion
module Chess
  module Piece
    class Pawn < Base
      def valid_moves
        result = []
        check_position = Position.normalize([@position.row + direction * 1, @position.col])
        if @board.fetch(check_position).empty?
          result << check_position
        end
        check_position = Position.normalize([@position.row + direction * 2, @position.col])
        if @board.fetch(check_position).empty? && @moves.empty?
          result << check_position
        end
        [
          [@position.row + direction * 1, @position.col - 1],
          [@position.row + direction * 1, @position.col + 1]
        ].each do |newr, newc|
          check_position = Position.normalize([newr, newc])
          other = @board.fetch(check_position).piece
          result << check_position if other && other.color != color
        end
        result
      end

      def direction
        if white?
          1
        else
          -1
        end
      end
    end
  end
end
