# Encapsulates functionality for pieces that move in a single direction.
# Provides private generalzied movement helpers for bishops, rooks and queens.
module Chess
  module Piece
    module Helper
      module Directions
        def directional_details(board)
          {
            north: {
              iteration: { row: 1, col: 0 },
              bounds: { row: { lt: @board.height - 1 } }
            },
            northeast: {
              iteration: { row: 1, col: 1 },
              bounds: { row: { lt: @board.height - 1 }, col: { lt: @board.width - 1 } }
            },
            east: {
              iteration: { row: 0, col: 1 },
              bounds: { col: { lt: @board.width - 1 } }
            },
            southeast: {
              iteration: { row: -1, col: 1 },
              bounds: { row: { gt: 0 }, col: { lt: @board.width - 1 } }
            },
            south: {
              iteration: { row: -1, col: 0 },
              bounds: { row: { gt: 0 } }
            },
            southwest: {
              iteration: { row: -1, col: -1 },
              bounds: { row: { gt: 0 }, col: { gt: 0 } }
            },
            west: {
              iteration: { row: 0, col: -1 },
              bounds: { col: { gt: 0 } }
            },
            northwest: {
              iteration: { row: 1, col: -1 },
              bounds: { row: { lt: @board.height - 1 }, col: { gt: 0 } }
            }
          }
        end
        private :directional_details

        def in_bounds?(row, col, bounds)
          (bounds[:row].nil? || (bounds[:row][:gt] && row > bounds[:row][:gt]) || (bounds[:row][:lt] && row < bounds[:row][:lt])) &&
            (bounds[:col].nil? || (bounds[:col][:gt] && col > bounds[:col][:gt]) || (bounds[:col][:lt] && col < bounds[:col][:lt]))
        end
        private :in_bounds?

        def valid_moves_heading(direction)
          details = directional_details(@board)[direction]
          raise ArgumentError, "Invalid direction: '#{direction}'" unless details

          results = []
          rowptr = @position.row
          colptr = @position.col
          while in_bounds?(rowptr, colptr, details[:bounds])
            rowptr += details[:iteration][:row]
            colptr += details[:iteration][:col]
            curpos = Position.normalize([rowptr, colptr])
            other = @board.fetch(curpos).piece
            break if other && other.color == @color
            results << curpos
            break if other && other.color != @color
          end
          results
        end
        private :valid_moves_heading
      end
    end
  end
end
