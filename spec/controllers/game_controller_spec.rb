require 'spec_helper'

describe GameController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'playing'" do
    it "returns http success" do
      post 'playing'
      response.should be_success
    end
  end

  describe "GET 'over'" do
    it "returns http success" do
      get 'over'
      response.should be_success
    end
  end

	describe "Checking guesses against secret code" do
	before :each do
		@fake_game=mock('game',:secret_code => "ABCD")
	end
		it "should return true if the guess == secret code" do
			Game.stub(:check_code).and_return("4")
			response.should render_template('game_over')
		end

	end

end
