# encoding: utf-8

require File.join(File.dirname(__FILE__), '..', 'ambitious_player')

describe AmbitiousPlayer do
  let(:player)          { AmbitiousPlayer.new }
  let(:ships_remaining) { [5,4,3,3,2] }

  describe "hunting" do
    it "should find the first unknown space and hit (space + (smallest_ship/2))" do
      board = [
        [:miss, :unknown, :unknown],
        [:unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown],
      ]
         
      player.take_turn(board, ships_remaining).should == [2,0]
    end
    
    it "should find the first unknown space and hit (space + (smallest_ship/2)) - example 2" do
      board = [
        [:miss, :unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown],
      ]
      
      ships_remaining = [5,4]      
      player.take_turn(board, ships_remaining).should == [3,0]
    end

    it "should find the first unknown space and hit (space + (smallest_ship/2)) - example 3" do
      board = [
        [:miss, :unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown]
      ]
      
      ships_remaining = [5,4,3]    
      player.take_turn(board, ships_remaining).should == [3,0]
    end
    
    it "should start in the top left corner" do
      board = [
        [:unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown]
      ]

      player.take_turn(board, ships_remaining).should == [0,0]      
    end
    
    it "should pick the first space with an unknown north" do    
      board = [
        [:miss, :unknown, :miss],
        [:unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown]
      ]

      player.take_turn(board, ships_remaining).should == [1,1]
    end
    
    it "should pick the first space with an unknown north - example 2" do    
      board = [
        [:miss, :unknown, :miss],
        [:unknown, :miss, :unknown],
        [:unknown, :unknown, :unknown]
      ]

      player.take_turn(board, ships_remaining).should == [0,2]
    end
  end

  describe "sinking" do
    it "should sink a ship in the top-left corner" do
      board = [
        [:hit, :unknown],
        [:unknown, :unknown]
      ]
    
      player.take_turn(board, ships_remaining).should == [1,0]
    end
    
    it "should sink a ship in the bottom right corner" do
      board = [
        [:unknown, :unknown],
        [:unknown, :hit]
      ]

      player.take_turn(board, ships_remaining).should == [1,0]
    end

    it "should sink a ship in the middle of the board" do
      board = [
        [:unknown, :unknown, :unknown],
        [:unknown, :hit, :unknown],
        [:unknown, :unknown, :unknown]
      ]

      player.take_turn(board, ships_remaining).should == [1,0]
    end

    it "should sink a ship in the middle of the board - example 2" do
      board = [
        [:miss, :miss, :unknown],
        [:hit, :hit, :unknown],
        [:unknown, :unknown, :unknown]
      ]

      player.take_turn(board, ships_remaining).should == [2,1]
    end
    
    it "should sink a ship in the middle of the board - example 3" do      
      board = [
        [:hit, :hit, :miss, :unknown],
        [:miss,:miss,:miss,:miss],
        [:hit, :unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown]
      ]

      player.take_turn(board, ships_remaining).should == [1,2]
    end

    it "should follow the direction of the boat" do
      board = [
        [:unknown, :hit, :unknown],
        [:unknown, :hit, :unknown],
        [:unknown, :unknown, :unknown]
      ]
      
      player.take_turn(board, ships_remaining).should == [1,2]
    end

    it "should follow the direction of the boat - example 2" do
      board = [
        [:unknown, :unknown, :unknown, :unknown],
        [:unknown, :hit, :unknown, :unknown],
        [:unknown, :hit, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown]
      ]
      
      player.take_turn(board, ships_remaining).should == [1,0]
    end

    it "should follow the direction of the boat - example 3" do
      board = [
        [:unknown, :unknown, :unknown, :unknown],
        [:unknown, :hit, :unknown, :unknown],
        [:unknown, :hit, :unknown, :unknown],
        [:unknown, :unknown, :unknown, :unknown]
      ]
      
      player.take_turn(board, ships_remaining).should == [1,0]
    end

    it "should follow the direction of the boat - example 4" do
      board = [
        [:unknown, :unknown, :unknown],
        [:hit, :hit, :unknown],
        [:unknown, :unknown, :unknown]
      ]
      
      player.take_turn(board, ships_remaining).should == [2,1]
    end

    it "should follow the direction of the boat - example 5" do
      board = [
        [:unknown, :unknown, :unknown],
        [:unknown, :hit, :hit],
        [:unknown, :unknown, :unknown],
        [:unknown, :unknown, :unknown]
      ]
      
      player.take_turn(board, ships_remaining).should == [0,1]
    end
    
    it "should follow the direction of the boat - example 6" do
      board = [
        [:miss, :hit, :unknown, :unknown],
        [:unknown, :hit, :miss, :unknown],
        [:hit, :hit, :miss, :unknown],
        [:unknown, :miss, :miss, :unknown]
      ]
      
      player.take_turn(board, ships_remaining).should == [1,0]
    end

    it "should follow the direction of the boat - example 7" do
      board = [
        [:miss, :hit, :unknown, :unknown],
        [:hit, :hit, :miss, :unknown],
        [:miss, :hit, :miss, :unknown],
        [:hit, :miss, :miss, :unknown]
      ]
      
      player.take_turn(board, ships_remaining).should == [1,0]
    end

    it "should not fire into a space too small for any boat remaining" do
      board = [
        [:miss, :unknown, :miss],
        [:hit, :hit, :hit],
        [:miss, :unknown, :unknown]
      ]

      player.take_turn(board, ships_remaining).should_not == [1,0]
    end

    it "should not fire into a space too small for any boat remaining - example 2" do
      board = [
        [:miss, :miss, :miss],
        [:hit, :unknown, :hit],
        [:miss, :unknown, :unknown]
      ]

      player.take_turn(board, ships_remaining).should == [1,1]
    end
  end
end