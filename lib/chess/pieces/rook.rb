module Chess
  module Piece
    class Rook < Base
      include Helper::Directions

      def valid_moves
        valid_moves_heading(:north) +
          valid_moves_heading(:west) +
          valid_moves_heading(:east) +
          valid_moves_heading(:south)
      end
    end
  end
end
