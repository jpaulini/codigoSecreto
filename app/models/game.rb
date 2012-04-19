class Game < ActiveRecord::Base
  has_many :game_guesses,  dependent: :destroy
  
  after_create :save_secret_code

  def check_code(text)
    text = "XXXX" if text.nil?
    @result=0
    @index=0
    text.upcase.each_char do |c|
      @result += 1 if self.secret_code[@index] == c
      @index += 1
    end
    return @result.to_s
  end
  
  private
  
  def save_secret_code
    self.secret_code = '????'
    self.save!
  end
  
  
end
