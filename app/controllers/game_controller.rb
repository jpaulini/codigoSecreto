class GameController < ApplicationController
  def new
    @game=Game.create!
    redirect_to game_playing_path(:id=> @game.id)
  end

  def playing
    @game = Game.find params[:id]
 
#    flash[:notice] = "#{@game.title} was successfully updated."
    if @game.check_code(params[:guessed_code]) == "4"
      redirect_to game_over_path(:id => @game.id)
    end
  end
      
  def over
  end

end
