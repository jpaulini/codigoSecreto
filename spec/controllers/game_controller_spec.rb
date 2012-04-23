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
        @game_guesses.stub(:ord).and_return(5)
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
      post :playing, {:game_id => @game.id, :code => {"0"=>"B", "1"=>"F", "2"=>"A", "3"=>"D"} } 


      @game.game_guesses.count.should be == 3
    end
    
    it 'Should store the number of guesses' do
      post :playing, {:game_id => @game.id, :code => {"0"=>"A", "1"=>"B", "2"=>"C", "3"=>"D"} }
      post :playing, {:game_id => @game.id, :code => {"0"=>"B", "1"=>"C", "2"=>"A", "3"=>"D"} } 
      post :playing, {:game_id => @game.id, :code => {"0"=>"B", "1"=>"F", "2"=>"A", "3"=>"D"} } 

     GameGuess.where(:game_id => @game.id, :code => "ABCD")[0].ord.should be == 1 and
     GameGuess.where(:game_id => @game.id, :code => "BCAD")[0].ord.should be == 2 and
     GameGuess.where(:game_id => @game.id, :code => "BFAD")[0].ord.should be == 3
  
    end
    
    it 'Should render the game over page if no success after 10 trials' do
    @game.stub(:check_code).and_return(0)
    @fake_guess=FactoryGirl.create(:game_guess, game_id: @game.id)
    @fake_guess.stub(:build).and_return(@fake_guess)
    @fake_guess.stub(:ord).and_return(10)
    @game.stub(:game_guesses).and_return(@fake_guess)
    
      post :playing, {:game_id => @game.id, :code => {"0"=>"A", "1"=>"B", "2"=>"C", "3"=>"D"} }

	  response.should redirect_to(:controller => 'game' , :action => 'over' ,:game_id => @game.id)
        
    end
    
    
  end

  describe 'Guess code sanity' do
  
  before :each do
        @game = FactoryGirl.create(:game, id: "121")
        Game.stub(:find).and_return(@game)
        @fake_guess = FactoryGirl.create(:game_guess, :game_id => @game_id, :code => "FBCD")
        @fake_guess.stub(:build).and_return(@fake_guess)
        @game.stub(:game_guesses).and_return(@fake_guess)
  end
  
    it 'should save the submitted code' do
      post :playing, {:game_id => @game.id, :code => {"0"=>"F", "1"=>"B", "2"=>"C", "3"=>"D"} }
      
      @guess = @game.game_guesses
      @guess.code.should be == "FBCD"
    end
    
  end  
  
  describe 'should maintain data when playing: ' do
    it 'Should maintain last code issued' do
      @game = FactoryGirl.create(:game, id: "222")
      Game.stub(:find).and_return(@game)
      
      post :playing, {:game_id => @game.id, :code => {"0"=>"F", "1"=>"B", "2"=>"C", "3"=>"D"} }
    
      assert session[:last_code] == {"0"=>"F", "1"=>"B", "2"=>"C", "3"=>"D"}
    end
  
  end
  
  
  
end
