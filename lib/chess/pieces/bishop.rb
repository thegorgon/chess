module Chess
  module Piece
    class Bishop < Base
      include Helper::Directions

      def valid_moves
        valid_moves_heading(:northwest) +
          valid_moves_heading(:northeast) +
          valid_moves_heading(:southwest) +
          valid_moves_heading(:southeast)
      end
    end
  end
end
