require 'spec_helper'

describe GameGuess do
  describe 'Game Guess creation' do
    it 'should create a new record when needed' do
      g=GameGuess.create!
      g.should_not be_nil
    end
    
    it 'should store in the ord field the sequence order' do
      t=Game.create!
      m1=t.game_guesses.build()
      m1.save
      m2=t.game_guesses.build()
      m2.save
      
      m2.ord.should be == 2
      
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
