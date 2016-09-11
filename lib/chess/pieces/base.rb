module Chess
  module Piece
    class Base
      attr_reader :name, :color, :moves

      def initialize(color, board)
        @name = self.class.to_s.split('::').last.downcase.to_sym
        @color = color
        @board = board
        @moves = []
      end

      def position=(position)
        @position = Position.normalize(position)
      end

      def move!(position)
        self.position = position
        @moves << self.position
      end

      def reset!
        @board = nil
        @position = nil
        @moves = []
      end
    end
  end
end
