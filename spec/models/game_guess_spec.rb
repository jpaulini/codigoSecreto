require 'spec_helper'

describe GameGuess do
  describe 'Game Guess creation' do
    it 'should create a new record when needed' do
      g=GameGuess.create!
      g.should_not be_nil
    end
  end
  
  describe 'finding game moves ' do
    it 'should retrieve an existing game by id' do
      a=GameGuess.create!()
      b=GameGuess.create!()
      
      result=GameGuess.find_by_id(a.id)
      result.should_not be_nil
    end
   end 
end
