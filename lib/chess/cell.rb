module Chess
  # The Cell class represents a cell on a chess board.
  # A Board contains many Cells.
  class Cell
    attr_reader :piece, :position

    def initialize(position)
      @piece = nil
      @position = Position.normalize(position)
    end

    def piece?
      !empty?
    end

    def empty?
      @piece.nil?
    end

    def clear!
      @piece = nil
    end

    def place!(piece)
      @piece = piece
    end
  end
end
