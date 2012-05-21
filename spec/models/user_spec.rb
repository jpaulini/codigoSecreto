require 'spec_helper'

describe User do
  it 'should raise error when no name posted' do
    #user=User.create!
    lambda { User.create! }.should raise_error(ActiveRecord::RecordInvalid)
  end
  
end
