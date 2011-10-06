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

  def look_for(ship_length)
    board.each_with_index do |row, y| # do we need this looping, or just use an array searcher?
      row.each_with_index do |state, x|
        next unless state == :hit

        puts y

        # north
        if (y-1) >= 0 and board[y-1][x] == :unknown
          puts "n"

          return [x, y-1]
        end

        # east
        if row[x+1] == :unknown
          puts "e"
          return [x+1, y]
        end

        # south
        if board[y+1] and board[y+1][x] == :unknown
          puts "s"
          return [x, y+1]
        end

        # west
        if row[x-1] == :unknown
          puts "w"
          return [x-1, y]
        end
        
      end
    end
  end
  
  def take_turn(board, ships_remaining)
    self.board = board
    self.ships_remaining = ships_remaining
    
    return look_for(smallest_ship_remaining)

    board.each_with_index do |row, y|
      row.each_with_index do |state, x|






        # next if s == :miss
        # 
        # if s == :hit
        #   if dir == :up
        #     
        #   else
        #     return []
        #   end
        #   
        # end

        next unless state == :unknown
        # log("going with it!")
        return [x, y]
      end
    end
  end

  private
  def direction(state) # should use state!
    dir = rand(2) == 1 ? :down : :across
  end
  
  def smallest_ship_remaining
    smallest_ship_remaining = ships_remaining.sort.first
  end
end