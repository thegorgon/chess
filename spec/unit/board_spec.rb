require 'spec_helper'

describe Chess::Board do
  let(:board) { Chess::Board.new }

  it 'initializes a grid with empty cells' do
    (0...8).each do |col|
      (0...8).each do |row|
        expect(board.fetch(row: row, col: col).position).to eq(row: row, col: col)
        expect(board.fetch(row: row, col: col)).to be_empty
      end
    end
  end
end
