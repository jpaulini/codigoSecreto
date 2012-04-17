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
        @game.stub(:id).and_return("1")     
        Game.stub(:find).with("1").and_return(@game)
      end

		it "should return true if the guess == secret code" do  
        @game.stub(:check_code).and_return("4")

        post :playing, {:game_id => "1"}
  		  response.should redirect_to(:controller => 'game' , :action => 'over' ,:game_id => '1')
		end
		
		it "should keep the playing page if failure" do
        @game.stub(:check_code).and_return("2")

        post :playing, {:game_id => "1"}
  		  response.should render_template('playing')
    end

	end
  
  describe 'Should keep all de guesses' do
    it 'should save all the guesses' do
      @game = mock('Game', :check_code =>"0")
      @game.stub(:id).and_return("10")
      Game.stub(:find).and_return(@game)

      post :playing, {:game_id => "10", :guessed_code => "ABCD" }
      post :playing, {:game_id => "10", :guessed_code => "BCDA" }
      GameGuess.find_all_by_game_id(@game.id).length.should be == 2
    end

    it 'should retrieve guesses given a game_id' do
      @game = mock('Game', :check_code =>"0")
      @fake_guesses = [ mock('GameGuess'), mock('GameGuess')]
      @game.stub(:id).and_return("10")
      Game.stub(:find).and_return(@game)
      GameGuess.stub(:find_all_by_game_id).with("10").and_return(@fake_guesses)
      
      post :playing, {:game_id => "10"}
      assigns(:game_guesses).should == @fake_guesses
    end
  end
end
