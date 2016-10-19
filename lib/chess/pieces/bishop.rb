# Defines a bishop with it's valid moves.
# Uses the `Directions` helper module to share code with queens and rooks.
module Chess
  module Piece
    class Bishop < Base
      include Helper::Directions

      def valid_moves
        [ :northwest,
          :northeast,
          :southwest,
          :southeast
        ].inject([]) do |memo, direction|
          memo += valid_moves_heading(direction)
          memo
        end
      end
    end
  end
end
