require './ambitious_player'


# work out what turn number is is by taking the number of unknown squares from the number of squares!

# priorities:
# 1) SINK - sink ships that we've already found
# 2) HUNT - find new ships to sink

# we need to look for ships! go for the smallest unsunk ship, find hits that could make up part of it and expand
# work up from the smallest, that's the simplest way.

# otherwise hunt for ships using checkerboard tactic, taking into account smallest unsunk ship

# START BY HUNTING FOR THE DESTROYER, then expand script


describe AmbitiousPlayer do
  let(:player) { AmbitiousPlayer.new }

  describe "sinking" do
    it "should sink a destroyer in the top-left corner" do
      board = [
        [:hit, :unknown],
        [:unknown, :hit]
      ]
    
      ships_remaining = [5,4,3,3,2]  
      player.take_turn(board, ships_remaining).should == [1,0]
    end
  
    it "should sink a destroyer in the middle of the board" do
      board = [
        [:unknown, :unknown, :unknown],
        [:unknown, :hit, :unknown],
        [:unknown, :unknown, :unknown]
      ]

      ships_remaining = [5,4,3,3,2]
      player.take_turn(board, ships_remaining).should == [1,0]
    end
  
    it "should sink a destroyer in the bottom right corner" do
      board = [
        [:unknown, :unknown],
        [:unknown, :hit]
      ]

      ships_remaining = [5,4,3,3,2] 
      player.take_turn(board, ships_remaining).should == [1,0]
    end
  end
end