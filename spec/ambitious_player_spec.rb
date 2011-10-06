require './ambitious_player'

describe AmbitiousPlayer do
  let(:player) { AmbitiousPlayer.new }

  describe "placing" do
    it "should gain strategic advantage through randomised placement"
  end

  describe "hunting" do
    it "should proceed in a chessboard pattern, based upon the smallest remaining ship"
    it "should hunt across if down has more shots"
    it "should hunt down if across has more shots"

    it "should not repeat moves already made" do
      # flakey test at the moment - but not needed as we won't choose duplicate squares soon
      
      player.stub!(:guess).and_return([0,0],[0,1])

      board = [
        [:miss, :unknown],
        [:unknown, :unknown]
      ]

      ships_remaining = [5,4,3,3,2]  

      player.take_turn(board, ships_remaining).should == [0,1]
    end
  end

  describe "sinking" do
    it "should sink a ship in the top-left corner" do
      board = [
        [:hit, :unknown],
        [:unknown, :unknown]
      ]
    
      ships_remaining = [5,4,3,3,2]  
      player.take_turn(board, ships_remaining).should == [1,0]
    end
  
    it "should sink a ship in the middle of the board" do
      board = [
        [:unknown, :unknown, :unknown],
        [:unknown, :hit, :unknown],
        [:unknown, :unknown, :unknown]
      ]

      ships_remaining = [5,4,3,3,2]
      player.take_turn(board, ships_remaining).should == [1,0]
    end
  
    it "should sink a ship in the bottom right corner" do
      board = [
        [:unknown, :unknown],
        [:unknown, :hit]
      ]

      ships_remaining = [5,4,3,3,2] 
      player.take_turn(board, ships_remaining).should == [1,0]
    end

    it "should sink a ship in the bottom right corner" do
      board = [
        [:miss, :miss, :unknown],
        [:hit, :hit, :unknown]
      ]

      ships_remaining = [5,4,3,3,2] 
      player.take_turn(board, ships_remaining).should == [2,1]
    end
    
    it "should not fire into a space too small for any boat remaining"
    
    it "should follow the direction of the boat"
    # ie, if we've hit two squares across in a row, priority should be to go across again!
  end
end