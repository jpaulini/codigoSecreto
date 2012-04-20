require 'spec_helper'

describe GameController do

  describe "GET 'over'" do
    it "returns http success" do
      get 'over'
      response.should be_success
    end
  end

  describe 'starting a new game'
    it 'should create a new record when I start a new game' do
      @game = mock('Game')
      @game.stub(:id).and_return("200")
      Game.stub(:create!).and_return(@game)
      
      get :new
 		  response.should redirect_to(:controller => 'game' , :action => 'start' ,:game_id => '200')
    end


	describe "Checking guesses against secret code" do
      before :each do
        @game = mock('Game')
        @game_guesses = mock('GameGuess',:save =>"")
        @game_guesses.stub(:build).and_return(@game_guesses)
        @game.stub(:id).and_return("1")     
        @game.stub(:game_guesses).and_return(@game_guesses)
        Game.stub(:find).with("1").and_return(@game)
      end

		it "should return true if the guess == secret code" do  
        @game.stub(:check_code).and_return("4")

        post :playing, {:game_id => "1", :code => {"0"=>"A", "1"=>"B", "2"=>"C", "3"=>"D"} }
  		  response.should redirect_to(:controller => 'game' , :action => 'over' ,:game_id => '1')
		end
		
		it "should keep the playing page if failure" do
        @game.stub(:check_code).and_return("2")

        post :playing, {:game_id => "1", :code => {"0"=>"A", "1"=>"B", "2"=>"C", "3"=>"D"}}
  		  response.should render_template('playing')
    end

	end
  
  describe 'Keeping all de guesses' do
  
  before :each do
        @game = FactoryGirl.create(:game)
        Game.stub(:find).and_return(@game)
  end
  
    it 'should save all the guesses' do
      post :playing, {:game_id => @game.id, :code => {"0"=>"A", "1"=>"B", "2"=>"C", "3"=>"D"} }
      post :playing, {:game_id => @game.id, :code => {"0"=>"B", "1"=>"C", "2"=>"A", "3"=>"D"} } 
      post :playing, {:game_id => @game.id, :code => {"0"=>"B", "1"=>"C", "2"=>"A", "3"=>"D"} } 


      @game.game_guesses.count.should be == 3
    end
  end

  describe 'Guess code sanity' do
  
  before :each do
        @game = FactoryGirl.build(:game_with_guesses)
        Game.stub(:find).and_return(@game)
        @fake_guess = FactoryGirl.build(:game_guess, :code => "ABCD")
        @fake_guess.stub(:build).and_return(@fake_guess)
        @game.stub(:game_guesses).and_return(@fake_guess)
  end
  
    it 'should save the submitted code' do
      post :playing, {:game_id => @game.id, :code => {"0"=>"A", "1"=>"B", "2"=>"C", "3"=>"D"} }
      
      @guess = @game.game_guesses
      @guess.code.should be == "ABCD"
    end
    
    it 'should save the submitted code and no other' do
      @fake_guess.code="DBCA"
      
      post :playing, {:game_id => @game.id, :code => {"0"=>"D", "1"=>"B", "2"=>"C", "3"=>"A"} }
      
      @guess = @game.game_guesses
      @guess.code.should_not == "ABCD"
    end
    
  end  
  
  
end
