# encoding: utf-8

class Board
  attr_accessor :state, :ships_remaining
  
  def initialize(state, ships_remaining)
    self.state = state
    self.ships_remaining = ships_remaining
  end
  
  def find(x, y)
    return nil unless space_exists?(x, y)    
    rows[y][x]
  end

  def next_sinking_move
    hits.each do |space|

      if space.isolated_hit?
        space.surroundings.each do |move|
          return move if move.active?
        end
      end

      return space.north  if space.south.try(:hit?) and space.north.try(:active?)
      return space.east   if space.west.try(:hit?)  and space.east.try(:active?)
      return space.south  if space.north.try(:hit?) and space.south.try(:active?)
      return space.west   if space.east.try(:hit?)  and space.west.try(:active?)
    end

    nil
  end
  
  def next_hunting_move
    unknowns.each do |space|
      interval = 0
      
      if space.y == 0 and space.x.odd?
        interval = (smallest_ship_remaining.to_f/2).ceil
      elsif space.north.try(:unknown?) == false
        interval = (smallest_ship_remaining.to_f/2).ceil
      end
      
      move = find(space.x + interval, space.y)
      
      return move if move.try(:active?)
    end
    
    random_unknown_move
  end

  private
  def rows
    rows = []
    state.each_with_index do |r, y|
      row = []
      r.each_with_index do |status, x|
        row << Space.new(x, y, status, self)
      end
      rows << row
    end
    
    rows    
  end
  
  def size
    rows.size - 1
  end
  
  def space_exists?(x, y)
    return false if x > size 
    return false if y > size
    return false if x < 0
    return false if y < 0
    
    true
  end
  
  def find_all(criteria)    
    rows.reduce([]) do |hits, row|
      hits += row.find_all(&criteria)
      hits
    end
  end

  def hits
    find_all(:hit?)
  end

  def unknowns
    find_all(:unknown?)
  end
  
  def random_unknown_move
    find_all(:active?).shuffle.first    
  end
  
  def smallest_ship_remaining
    ships_remaining.sort.first
  end
end