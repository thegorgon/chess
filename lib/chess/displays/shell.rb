module Chess
  module Display
    # A Unix shell specific rendering engine.
    class Shell
      CHARACTERS = {
        black: {
          king: "\u2654",
          queen: "\u2655",
          rook: "\u2656",
          bishop: "\u2657",
          knight: "\u2658",
          pawn: "\u2659"
        },
        white: {
          king: "\u265A",
          queen: "\u265B",
          rook: "\u265C",
          bishop: "\u265D",
          knight: "\u265E",
          pawn: "\u265F"
        },
        empty: '_'
      }.freeze

      def initialize(out)
        @out = out
      end

      def clear!
        print "\e[H\e[2J"
      end

      def say(message)
        print message
        newline
      end

      def draw(game)
        newline
        game.board.each_row(game.playing) do |row, i|
          print "#{i + 1} "
          row.each do |cell, _|
            print_cell(cell)
          end
          newline
        end
        print '   a  b  c  d  e  f  g  h'
        newline
      end

      private

      def print(string)
        @out.print string
      end

      def print_cell(cell)
        if cell.piece?
          print " #{CHARACTERS[cell.piece.color][cell.piece.name]} "
        else
          print " #{CHARACTERS[:empty]} "
        end
      end

      def newline
        print "\n"
      end
    end
  end
end
