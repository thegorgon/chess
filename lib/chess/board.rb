module Chess
  # The Board class represents a chess board.
  class Board
    WIDTH = 8
    HEIGHT = 8

    attr_reader :width, :height

    def initialize
      @width = WIDTH
      @height = HEIGHT
      @pieces = []
      @grid = Array.new(@height) { Array.new(@width) { nil } }
      (0...@height).each do |j|
        (0...@width).each do |i|
          @grid[j][i] = Cell.new(Position.from_indices(row: i, col: j))
        end
      end
    end

    def each_col
      @grid.each_with_index do |col, j|
        yield(col, j)
      end
    end

    def each_row(color = :white)
      iterator = color == :white ? (WIDTH - 1).downto(0) : WIDTH.times
      iterator.each do |i|
        row = @grid.map { |col| col[i] }
        yield(row, i)
      end
    end

    def each_cell
      each_row do |row, i|
        row.each_with_index do |cell, j|
          yield(cell, i, j)
        end
      end
    end

    def fetch(position)
      position = Position.normalize(position)
      @grid[position.col][position.row]
    end

    def place!(piece, position)
      @pieces << piece unless @pieces.include?(piece)
      piece.position = position
      fetch(position).place!(piece)
    end

    def move!(move)
      move = Move.normalize(move)
      piece = fetch(move.start_position).piece
      piece.move!(move)
      fetch(move.end_position).place!(piece)
      fetch(move.start_position).clear!
    end

    def clear!
      each_cell { |cell, _, _| cell.clear! }
    end
  end
end
