module Chess
  module Engine
    class Shell
      def initialize(_options)
        @game = Game.new
        @message = nil
        @display = Chess::Display::Shell.new($stdout)
      end

      def start!
        until @game.finished?
          @display.clear!
          @display.say(@message || '')
          @message = nil
          @display.draw(@game)
          move = prompt_for_move
          break unless move
          result = @game.play!(move)
          if result.invalid_color?
            @message = 'Nice try. Move your own piece!'
          elsif result.invalid_move?
            @message = "That's not a valid move!"
          elsif result.empty_cell?
            @message = "There's no piece on that cell!"
          end
        end
      end

      def prompt_for_move
        @display.say "#{@game.playing.to_s.capitalize}'s move:"
        move_string = gets.strip
        return false if move_string == 'exit'
        Move.normalize(move_string)
      end
    end
  end
end
