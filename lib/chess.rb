require 'bundler'
require 'ostruct'

Bundler.require

module Chess
  COLUMNS = %w(a b c d e f g h).freeze
  COLORS = OpenStruct.new(white: :white, black: :black)
end

require 'chess/position'
require 'chess/move'
require 'chess/move_result'
require 'chess/displays/shell'
require 'chess/pieces/base'
require 'chess/pieces/helpers/directions'
require 'chess/pieces/bishop'
require 'chess/pieces/king'
require 'chess/pieces/knight'
require 'chess/pieces/pawn'
require 'chess/pieces/queen'
require 'chess/pieces/rook'
require 'chess/cell'
require 'chess/board'
require 'chess/game'
require 'chess/engines/shell'
