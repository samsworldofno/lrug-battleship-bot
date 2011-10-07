class AmbitiousPlayer
  attr_accessor :board, :ships_remaining
  
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
    self.board = board
    self.ships_remaining = ships_remaining
    
    return sink! || hunt!
  end
  
  private
  def space_exists(x, y)
    return false if y > (board.size - 1)
    return false if x > (board.size - 1)
    return false if x < 0
    return false if y < 0

    true
  end
  
  def is_space?(x, y, status)
    return false unless space_exists(x, y)
    return true if board[y][x] == status

    false
  end
  
  def unknown?(x, y)
    is_space?(x, y, :unknown)
  end
  
  def hit?(x, y)
    is_space?(x, y, :hit)
  end
  
  def sunk?(x, y)
    false
  end
  
  def sink!
    board.each_with_index do |row, y| # do we need this looping, or just use an array searcher?
      row.each_with_index do |state, x|
        next unless hit?(x, y)
        
        next if sunk?(x, y)
        
        if hit?(x, y + 1) and unknown?(x, y - 1)
          puts "n (h)"
          return [x, y - 1]
        end

        if hit?(x - 1, y) and unknown?(x + 1, y)
          puts "e (h)"
          return [x + 1, y]
        end
        
        if hit?(x, y - 1) and unknown?(x, y + 1)
          puts "s (h)"
          return [x, y + 1]
        end

        if hit?(x + 1, y) and unknown?(x - 1, y)
          puts "w (h)"
          return [x - 1, y]
        end
      end
    end

    board.each_with_index do |row, y|
      row.each_with_index do |state, x|
        next unless state == :hit
   
        # turn this into an array of possible moves, then iterate
        # need to DRY up this block with the one above
        
        north = [x, y -1]
        if unknown?(*north) and big_enough?(*north)
          puts "n"
          return north
        end
        
        if unknown?(x + 1, y)
          puts "e"
          return [x + 1, y]
        end
        
        if unknown?(x, y + 1)
          puts "s"
          return [x, y + 1]
        end
        
        if unknown?(x - 1, y)
          puts "e"
          return [x - 1, y]
        end
      end
    end

    nil
  end
  
  def big_enough?(x, y)
    return true # remove this!
    
    surroundings(x, y).each do |move|
      return false unless unknown?(*move)
    end
    
    true
  end
  
  def surroundings(x, y)
    {
      :north => [x, y - 1],
      :east  => [x + 1, y],
      :south => [x, y + 1],
      :west  => [x - 1, y]
    }.values
  end
  
  
  def generate_move      
    board.each_with_index do |row, y|
      row.each_with_index do |state, x|
        next unless state == :unknown

        if x == 0 and y.even?
          interval = 0
        else
          interval = (smallest_ship_remaining.to_f/2).ceil
        end        
        
        return [x + interval, y] if unknown?(x + interval, y)
      end
    end
    
    [rand(board.size), rand(board.size)] # fallback
  end
  
  def smallest_ship_remaining
    ships_remaining.sort.first
  end
    
  def hunt!
    move = generate_move
    
    puts "hunting!"

    return move if unknown?(*move)
    return hunt!
  end
end