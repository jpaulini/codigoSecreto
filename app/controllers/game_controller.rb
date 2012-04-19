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
    @game.game_guesses.build(:code => params[:guessed_code])

#    flash[:notice] = "#{@game.title} was successfully updated."
    if @game.check_code(params[:guessed_code]) == "4"
      redirect_to game_over_path(:game_id => @game.id)
    end
  end
      
  def over
  end

end
