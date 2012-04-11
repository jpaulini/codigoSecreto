class Game < ActiveRecord::Base
  after_create {
    self.secret_code = 'ABCD'
    self.save!
  }
  
end
