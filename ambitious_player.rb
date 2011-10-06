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
  def sink!
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
        if (x-1) >= 0 and row[x-1] == :unknown
          puts "w"
          return [x-1, y]
        end     
      end
      

    end
    nil
  end
  
  def generate_move
    # determine best direction to proceed - could randomise initially, or just always go across
    # transpose if direction is :down?
    # find the first :unknown in this direction
    # hit space which is (:unknown + (smallest_remaining -1))
    # eg :unknown is position 0 and destroyer exists, hit 1
    # eg :unknown is position 2 and frigate exists, hit 4
    
    [rand(board.size), rand(board.size)]
  end
  
  def hunt!
    move = generate_move
    
    return move if board[move[1]][move[0]] == :unknown # this won't be necessary once generate move is smarter - put all logic in to this method :)
    return hunt!
  end
end