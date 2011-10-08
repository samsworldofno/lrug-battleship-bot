class StupidPlayer
  def name
    "Stupid Player"
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

  def take_turn(state, ships_remaining)
    [rand(10), rand(10)]
  end
end
