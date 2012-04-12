class Game < ActiveRecord::Base
  after_create {
    self.secret_code = 'ABCD'
    self.save!
  }
  
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
  
end
