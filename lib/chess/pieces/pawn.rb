module Chess
  module Piece
    class Pawn < Base
      def valid_moves
        result = []
        if @board.fetch([@position.row + 1, @position.col]).empty?
          result << Position.normalize([@position.row + 1, @position.col])
        end
        if @board.fetch([@position.row + 2, @position.col]).empty? && @moves.empty?
          result << Position.normalize([@position.row + 2, @position.col])
        end
        [
          [@position.row + 1, @position.col - 1],
          [@position.row + 1, @position.col + 1]
        ].each do |newr, newc|
          other = @board.fetch([newr, newc]).piece
          result << Position.normalize([newr, newc]) if other && other.color != color
        end
        result
      end
    end
  end
end
