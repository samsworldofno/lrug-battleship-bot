# encoding: utf-8

class Space
  attr_accessor :x, :y, :status, :board
  
  def initialize(x, y, status, board)
    self.x = x
    self.y = y
    self.status = status
    self.board = board
  end

  def to_a
    [x, y]
  end

  def active?
    unknown? and surroundings_clear?
  end

  def hit?
    status == :hit
  end

  def miss?
    status == :miss
  end
  
  def unknown?
    status == :unknown
  end

  def isolated_hit?
    surroundings.compact.each do |space|
      return false if space.hit?
    end
    
    true
  end

  def north
    board.find(x, y - 1)
  end
  
  def east
    board.find(x + 1, y)
  end
  
  def south
    board.find(x, y + 1)
  end
  
  def west
    board.find(x - 1, y)
  end

  def surroundings
    [north, east, south, west].compact
  end

  private  
  def surroundings_clear?
    return true
    surroundings.each do |space|
      return true if space.unknown? or space.isolated_hit? 
    end
    
    false
  end
end