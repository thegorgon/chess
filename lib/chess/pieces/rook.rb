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
