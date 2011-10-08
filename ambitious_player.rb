# encoding: utf-8

require 'object'
require 'board'
require 'space'

class AmbitiousPlayer
  attr_accessor :board
  
  def name
    "Ambitious Player"
  end
  
  def new_game
    [
      [2, 2, 5, :down],
      [5, 1, 4, :across],
      [0, 9, 3, :across],
      [5, 3, 3, :down],
      [5, 7, 2, :down]
    ]
  end

  def take_turn(board, ships_remaining)
    self.board = Board.new(board, ships_remaining)
    
    sink! or hunt!
  end
  
  private
  def sink!
    if move = board.next_sinking_move
      return move.to_a
    end
  end

  def hunt!
    board.next_hunting_move.to_a
  end
end