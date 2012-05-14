require 'spec_helper'

describe GameController do

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
        @game_guesses.stub(:result=).and_return("")
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

  
  describe 'should maintain data when playing: ' do
    before :each do
      @game = FactoryGirl.create(:game_with_guesses, guess_count: 3, id: "333")
      Game.stub(:find).and_return(@game)
    end

    it 'session should maintain last code issued' do
      
      post :playing, {:game_id => @game.id, :code => {"0"=>"F", "1"=>"B", "2"=>"C", "3"=>"D"} }
    
      assert session[:last_code] == {"0"=>"F", "1"=>"B", "2"=>"C", "3"=>"D"}
    end
    
    it 'Should maintain last result in game_guess table' do
      
      post :playing, {:game_id => @game.id, :code => {"0"=>"F", "1"=>"B", "2"=>"C", "3"=>"D"} }
    
      assert GameGuess.find_all_by_game_id(@game.id).last.code.should be == "FBCD"
    end
    
    it 'Should maintain results of each guess' do
      #chequear que haya guardado el resultado en cada item      
      @fake_guess=@game.game_guesses.last
      @fake_guess.stub(:build).and_return(@fake_guess)
      @game.stub(:game_guesses).and_return(@fake_guess)
      @game.stub(:check_code).and_return(2)
            
      post :playing, {:game_id => @game.id, :code => {"0"=>"F", "1"=>"B", "2"=>"C", "3"=>"D"} }

      assert @fake_guess.result.should be == 2
    end
  end

  describe 'Should check results'  
  it 'Show a message when player wins' do
    @game = FactoryGirl.create(:game_with_guesses_and_won, id: "335")
    Game.stub(:find).and_return(@game)
          
    post :over, {:game_id => @game.id}
    assigns(:message).should be == "Muy bien!"

  end

  it 'Show a message when player lose' do
    @game = FactoryGirl.create(:game_with_guesses, guess_count: 10, id: "336")
    Game.stub(:find).and_return(@game)
          
    post :over, {:game_id => @game.id}

    assigns(:message).should be == "Mala suerte!"
  end
 
  
end
