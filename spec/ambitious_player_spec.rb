require './ambitious_player'

describe AmbitiousPlayer do
  let(:player) { AmbitiousPlayer.new }

  describe "placing" do
    it "should gain strategic advantage through randomised placement"
  end

  describe "hunting" do
    it "should find the first unknown space and hit (space + (smallest_ship/2))" do
      board = [
        [:miss, :unknown, :unknown],
        [:unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown],
      ]
      
      ships_remaining = [5,4,3,3,2]
      
      player.take_turn(board, ships_remaining).should == [2,0]
    end
    
    it "should find the first unknown space and hit (space + (smallest_ship/2)) - second example" do
      board = [
        [:miss, :unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown],
      ]
      
      ships_remaining = [5,4]
      
      player.take_turn(board, ships_remaining).should == [3,0]
    end

    it "should find the first unknown space and hit (space + (smallest_ship/2)) - third example" do
      board = [
        [:miss, :unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown]
      ]
      
      ships_remaining = [5,4,3]
      
      player.take_turn(board, ships_remaining).should == [3,0]
    end
    
    it "should pick the first space on entirely unknown even rows" do
      board = [
        [:miss, :unknown],
        [:unknown, :miss],
        [:unknown, :unknown]
        
      ]

      ships_remaining = [5,4,3,3,2]
      
      player.take_turn(board, ships_remaining).should == [0,2]
    end
    
    it "should pick the second space on entirely unknown odd rows" do
      board = [
        [:miss, :unknown],
        [:unknown, :unknown]
      ]

      ships_remaining = [5,4,3,3,2]
      
      player.take_turn(board, ships_remaining).should == [1,1]
    end

    it "should not repeat moves already made" do
      board = [
        [:miss, :unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown]
      ]

      player.stub!(:generate_move).and_return([0,0],[0,1])
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

    it "should sink a ship in the middle of the board" do
      board = [
        [:miss, :miss, :unknown],
        [:hit, :hit, :unknown],
        [:unknown, :unknown, :unknown]
      ]

      ships_remaining = [5,4,3,3,2] 
      player.take_turn(board, ships_remaining).should == [2,1]
    end

    it "should follow the direction of the boat" do
      board = [
        [:unknown, :hit, :unknown],
        [:unknown, :hit, :unknown],
        [:unknown, :unknown, :unknown]
      ]
      
      ships_remaining = [5,4,3,3,2]
      player.take_turn(board, ships_remaining).should == [1,2]
    end

    it "should follow the direction of the boat - example 2" do
      board = [
        [:unknown, :unknown, :unknown, :unknown],
        [:unknown, :hit, :unknown, :unknown],
        [:unknown, :hit, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown]
      ]
      
      ships_remaining = [5,4,3,3,2]
      player.take_turn(board, ships_remaining).should == [1,0]
    end

    it "should follow the direction of the boat - example 3" do
      board = [
        [:unknown, :unknown, :unknown, :unknown],
        [:unknown, :hit, :unknown, :unknown],
        [:unknown, :hit, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown]
      ]
      
      ships_remaining = [5,4,3,3]
      player.take_turn(board, ships_remaining).should == [1,0]
    end

    it "should follow the direction of the boat - example 4" do
      board = [
        [:unknown, :unknown, :unknown],
        [:hit, :hit, :unknown],
        [:unknown, :unknown, :unknown]
      ]
      
      ships_remaining = [5,4,3,3,2]
      player.take_turn(board, ships_remaining).should == [2,1]
    end

    it "should follow the direction of the boat - example 5" do
      board = [
        [:unknown, :unknown, :unknown],
        [:unknown, :hit, :hit],
        [:unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown]
      ]
      
      ships_remaining = [5,4,3,3,2]
      player.take_turn(board, ships_remaining).should == [0,1]
    end

    it "should determine when a boat is sunk and follow the hunting pattern" do
      board = [
        [:unknown, :unknown, :unknown],
        [:hit, :hit, :unknown],
        [:unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown]
      ]
      
      ships_remaining = [5,4,3,3]
      
      player.should_receive(:hunt!)
      
      player.take_turn(board, ships_remaining).should == [2,1] # remove this? just need to be sure it came through the hunt method!
    end

    it "should not fire into a space too small for any boat remaining" do
      board = [
        [:miss, :unknown, :miss],
        [:hit, :hit, :hit],
        [:miss, :unknown, :unknown]
      ]

      ships_remaining = [5,4,3,3,2]

      player.should_receive(:hunt!)
      player.take_turn(board, ships_remaining).should == [2,2] # remove this? just need to be sure it came through the hunt method!
    end
    
    it "should not fire around sunken boats"
  end
end