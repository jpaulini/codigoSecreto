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
 		  response.should redirect_to(:controller => 'game' , :action => 'playing' ,:id => '200')
    end


	describe "Checking guesses against secret code" do
      before :each do
        @game = mock('Game')
        @game.stub(:id).and_return("1")     
        Game.stub(:find).with("1").and_return(@game)
      end

		it "should return true if the guess == secret code" do  
        @game.stub(:check_code).and_return("4")

        post :playing, {:id => "1"}
  		  response.should redirect_to(:controller => 'game' , :action => 'over' ,:id => '1')
		end
		
		it "should keep the playing page if failure" do
        @game.stub(:check_code).and_return("2")

        post :playing, {:id => "1"}
  		  response.should render_template('playing')
    end

	end

end
