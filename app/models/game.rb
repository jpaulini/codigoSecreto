class Game < ActiveRecord::Base
  belongs_to :user
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
    r=Random.new(Time.new().to_i)
    self.secret_code="    "
    letters='ABCDEF'
    4.times do |index|
      choosen=letters[r.rand(0..5-index)]
      self.secret_code[index] = choosen
      letters=letters.delete(choosen)
    end
    self.save!
  end
  
  
end
