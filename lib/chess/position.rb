module Chess
  class Position
    attr_reader :row, :col, :id

    def initialize(row: nil, col: nil, id: nil)
      @row = row
      @col = col
      @id = id
    end
    private_class_method :new

    def self.normalize(object)
      case object
      when String
        from_id(object)
      when Array
        from_array(object)
      when Hash
        from_indices(object)
      when Chess::Position
        object
      else
        raise ArgumentError, "Invalid position: #{object}"
      end
    end

    def self.from_id(id)
      raise ArgumentError, "Invalid position: #{id}" unless id.length == 2
      col = Chess::COLUMNS.index(id[0])
      row = id[1].to_i - 1
      raise ArgumentError, "Invalid row position: #{id}" unless row >= 0 && row <= 7
      raise ArgumentError, "Invalid column position: #{id}" unless col && col >= 0 && col <= 7
      from_indices(row: row, col: col)
    end

    def self.from_indices(row:, col:)
      raise ArgumentError, "Invalid row position: #{row}" unless row >= 0 && row <= 7
      raise ArgumentError, "Invalid column position: #{col}" unless col && col >= 0 && col <= 7
      id = "#{Chess::COLUMNS[col]}#{(row + 1)}"
      new(row: row, col: col, id: id)
    end

    def self.from_array(array)
      raise ArgumentError, "Invalid array: #{array}" unless array.length == 2
      from_indices(row: array[0], col: array[1])
    end

    def ==(other)
      if other.is_a?(Chess::Position)
        id == other.id && row == other.row && col == other.col
      else
        begin
          self == self.class.normalize(other)
        rescue ArgumentError
          false
        end
      end
    end
  end
end
