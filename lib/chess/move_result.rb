module Chess
  class MoveResult
    def initialize(status)
      @status = status
    end

    SUCCESS = MoveResult.new(:success)
    INVALID_COLOR = MoveResult.new(:invalid_color)
    INVALID_MOVE = MoveResult.new(:invalid_move)
    EMPTY_CELL = MoveResult.new(:empty_cell)

    private_class_method :new

    def success?
      @status == :success
    end

    def invalid_color?
      @status == :invalid_color
    end

    def invalid_move?
      @status == :invalid_move
    end

    def empty_cell?
      @status == :empty_cell
    end
  end
end
