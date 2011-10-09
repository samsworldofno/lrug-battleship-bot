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
  
  def shot_at?
    hit? or miss?
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
    # easily confused by boats touching each other...
    return false unless self.hit?
    
    s = {
      :north => north,
      :east => east,
      :south => south,
      :west => west
      
    }
    
    s.each do |direction, space|
      next if space.nil?
      
      return false if space.hit? and space.try(direction).try(:shot_at?)
      return true if space.unknown? and (space.try(direction).try(:hit?))
      
      return false if space.hit?
      
    end
    
    # surroundings.compact.each do |space|
    #   return false if space.hit?
    # end
    
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

  def surroundings_clear?
    surroundings.each do |space|
      return true if space.unknown? or space.isolated_hit? 
    end
    
    false
  end
end