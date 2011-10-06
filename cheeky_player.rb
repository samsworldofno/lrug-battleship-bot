require File.join(File.dirname(__FILE__), 'lib', 'player_please')

class CheekyPlayer
  include PlayerPlease
  
  def name
    "Cheeky Player"
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
    board.each_with_index do |row, y|
      row.each_with_index do |state, x|
        next unless state == :unknown
        return [x, y]
      end
    end
  end
  
  private
  def direction(state) # should use state!
    dir = rand(2) == 1 ? :down : :across
  end
end