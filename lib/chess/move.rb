module Chess
  class Move
    STRING_REGEX = /^[a-h][1-8]\-[a-h][1-8]$/
    attr_reader :start_position, :end_position

    def initialize(start_position, end_position)
      @start_position = Position.normalize(start_position)
      @end_position = Position.normalize(end_position)
    end
    private_class_method :new

    def self.normalize(object)
      case object
      when String
        from_string(object)
      when Array
        from_array(object)
      when Hash
        from_hash(object)
      when Move
        object
      else
        raise ArgumentError, "Invalid move: #{object}"
      end
    end

    def self.from_string(string)
      raise ArgumentError, "Invalid move string: #{string}" if string.match(STRING_REGEX).nil?
      new(*string.split('-'))
    end

    def self.from_hash(hash)
      raise ArgumentError, "Invalid move hash: #{hash}" unless hash.keys.sort == [:end, :start]
      new(hash[:start], hash[:end])
    end

    def self.from_array(array)
      raise ArgumentError, "Invalid move array: #{array}" unless array.count == 2
      new(array[0], array[1])
    end

    def ==(other)
      return false unless other.is_a?(Move)
      start_position == other.start_position &&
        end_position == other.end_position
    end
  end
end
