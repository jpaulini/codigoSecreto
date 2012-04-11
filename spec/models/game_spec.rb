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
      a=Game.create!(:id => '1')
      b=Game.create!(:id => '2')
      
      result=Game.find_by_id('1')
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
end
