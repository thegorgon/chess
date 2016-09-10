require 'spec_helper'

describe Chess::MoveResult do
  describe '.new' do
    it 'is private' do
      expect { described_class.new(:success) }.to raise_error NoMethodError
    end
  end

  describe '::SUCCESS' do
    it 'is success' do
      expect(described_class::SUCCESS).to be_success
    end

    it 'is nothing else' do
      expect(described_class::SUCCESS).to_not be_invalid_color
      expect(described_class::SUCCESS).to_not be_invalid_move
      expect(described_class::SUCCESS).to_not be_empty_cell
    end
  end

  describe '::INVALID_COLOR' do
    it 'is invalid_color' do
      expect(described_class::INVALID_COLOR).to be_invalid_color
    end

    it 'is nothing else' do
      expect(described_class::INVALID_COLOR).to_not be_success
      expect(described_class::INVALID_COLOR).to_not be_invalid_move
      expect(described_class::INVALID_COLOR).to_not be_empty_cell
    end
  end

  describe '::INVALID_MOVE' do
    it 'is invalid_move' do
      expect(described_class::INVALID_MOVE).to be_invalid_move
    end

    it 'is nothing else' do
      expect(described_class::INVALID_MOVE).to_not be_success
      expect(described_class::INVALID_MOVE).to_not be_invalid_color
      expect(described_class::INVALID_MOVE).to_not be_empty_cell
    end
  end

  describe '::EMPTY_CELL' do
    it 'is empty_cell' do
      expect(described_class::EMPTY_CELL).to be_empty_cell
    end

    it 'is nothing else' do
      expect(described_class::EMPTY_CELL).to_not be_success
      expect(described_class::EMPTY_CELL).to_not be_invalid_color
      expect(described_class::EMPTY_CELL).to_not be_invalid_move
    end
  end
end
