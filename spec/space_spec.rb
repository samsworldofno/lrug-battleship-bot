# encoding: utf-8

require File.join(File.dirname(__FILE__), '..', 'lib', 'object')
require File.join(File.dirname(__FILE__), '..', 'lib', 'board')
require File.join(File.dirname(__FILE__), '..', 'lib', 'space')

describe Space do

  it "should identify a hit that is not yet part of a sunk ship" do
    state = [
      [:miss,     :hit],
      [:unknown,  :unknown],
    ]
    
    ships_remaining = [5,4,3,2]
    
    board = Board.new(state, ships_remaining)

    space = board.find(1,0)
    space.isolated_hit?.should be_true
  end

  it "should identify a hit that is not yet part of a sunk ship - example 2" do
    state = [
      [:miss,     :unknown, :hit,   :unknown],
      [:unknown,  :unknown, :hit,   :unknown],
      [:hit,      :unknown, :hit,   :unknown],
      [:unknown,  :miss,    :miss,  :unknown]
    ]
    
    ships_remaining = [5,4,3,2]
    
    board = Board.new(state, ships_remaining)

    space = board.find(0,2)
    space.isolated_hit?.should be_true
  end
  
  it "should identify a hit that is not yet part of a sunk ship - example 3" do
    state = [
      [:hit,     :hit,   :unknown, :unknown],
      [:unknown,  :hit,   :miss,    :unknown],
      [:hit,      :hit,   :miss,    :unknown],
      [:unknown,  :miss,  :miss,    :unknown]
    ]
    
    ships_remaining = [5,4,3,2]
    
    board = Board.new(state, ships_remaining)

    space = board.find(0,2)
    space.isolated_hit?.should be_true
  end
end
