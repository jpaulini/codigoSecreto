class GameGuess < ActiveRecord::Base
  belongs_to :game
  after_create :ord_sequence_number
  
  private
  
  def ord_sequence_number
    seq=GameGuess.find_all_by_game_id(self.game_id).count
    self.ord=seq
    self.save
  end
end
