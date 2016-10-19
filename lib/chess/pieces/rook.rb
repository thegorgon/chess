# Defines a rook with it's valid moves.
# Uses the Directions helper module to share code with queens and bishops.
module Chess
  module Piece
    class Rook < Base
      include Helper::Directions

      def valid_moves
        [ :north,
          :west,
          :east,
          :south
        ].inject([]) do |memo, direction|
          memo += valid_moves_heading(direction)
          memo
        end
      end
    end
  end
end
