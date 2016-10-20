module Chess
  module Piece
    # Defines a queen with it's valid moves.
    # Uses the Directions helper module to share code with rooks and bishops.
    class Queen < Base
      include Helper::Directions

      def valid_moves
        [
          :north,
          :northwest,
          :west,
          :southwest,
          :south,
          :southeast,
          :east,
          :northeast
        ].inject([]) do |memo, direction|
          memo += valid_moves_heading(direction)
          memo
        end
      end
    end
  end
end
