require 'spec_helper'
#  pending "add some examples to (or delete) #{__FILE__}"

describe Game do
  describe 'Game creation' do
    it 'should create a new record when needed' do
      g=Game.create!
      g.should_not be_nil
    end
  end
  
  describe 'finding games' do
    it 'should retrieve an existing game by id' do
      a=Game.create!
            
      result=Game.find_by_id(a.id)
      result.should_not be_nil
    end
    
    it 'should assign nil when looking for a non existing game' do
      a=Game.create!(:id => '1')
      b=Game.create!(:id => '2')
      
      result=Game.find_by_id('3')
      result.should be_nil
    end
    
    it 'should assign a secret code when created' do
      a=Game.create!
      a.secret_code.should_not be_nil
    end
    
  end

 	describe "Checking check code method invocation" do
    it 'should call check code and return a number' do
      @game=Game.create!
 	    @game.check_code("ABCD").should match /[0-4]/
    end

    it 'should return 0 if there is no match' do
      @game=Game.create!
      @game.secret_code="XXXX"
 	    @game.check_code("ABCD").should == 0.to_s
    end
	  
	  it 'should have a length of 4' do
      @game=Game.create!
      @game.secret_code.length.should == 4

	  end
	  
	  it 'should return 1 if matched in the same position' do
      @game=Game.create!
      @game.secret_code="XBXX"
      @game.check_code("ABCD").should == 1.to_s and @game.check_code("BCDA").should == 0.to_s
	  
	  end
	  
	  it 'should return 0 if called with nil' do
      @game=Game.create!
      @game.check_code(nil).should == 0.to_s
	  end
	  
  end

end
