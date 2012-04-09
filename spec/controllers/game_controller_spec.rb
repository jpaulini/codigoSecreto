require 'spec_helper'

describe GameController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'playing'" do
    it "returns http success" do
      get 'playing'
      response.should be_success
    end
  end

  describe "GET 'over'" do
    it "returns http success" do
      get 'over'
      response.should be_success
    end
  end

end
