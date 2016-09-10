require 'spec_helper'

describe 'test setup' do
  it 'runs' do
    expect(Chess::COLORS.white).to eq :white
  end
end
