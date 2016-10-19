module Chess
  module Piece
    class Queen < Base
      include Helper::Directions

      def valid_moves
        [ :north,
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
