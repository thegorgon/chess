# Base piece class. Defines the basic functionality of a chess piece.
# All pieces descend from this class
module Chess
  module Piece
    class Base
      attr_reader :name, :color, :moves

      def initialize(color, board)
        raise ArgumentError, "Invalid color #{color}" unless color == Chess::COLORS.white || color == Chess::COLORS.black
        @name = self.class.to_s.split('::').last.downcase.to_sym
        @color = color
        @board = board
        @moves = []
      end

      def white?
        @color == Chess::COLORS.white
      end

      def black?
        @color == Chess::COLORS.black
      end

      def position=(position)
        @position = Position.normalize(position)
      end

      def move!(move)
        self.position = move.end_position
        @moves << move
      end

      def reset!
        @board = nil
        @position = nil
        @moves = []
      end
    end
  end
end
