class GameController < ApplicationController
  def new
    @game=Game.create!
     redirect_to game_start_path(:game_id => @game.id)
  end
  
  def start
    @game = Game.find params[:game_id]
  end

  def playing
    @game = Game.find params[:game_id]
    session[:last_code] = params[:code]
    
    code_text = params[:code].values.join if not params[:code].nil?
    guess = @game.game_guesses.build(code: code_text )
    guess.result = @game.check_code(@code_text)
    guess.save

    if @game.check_code(@code_text) == "4"
      redirect_to game_over_path(:game_id => @game.id)
    end
    
    if guess.ord == 10 
      redirect_to game_over_path(:game_id => @game.id)
    end
    
  end
      
  def over
  end

end
