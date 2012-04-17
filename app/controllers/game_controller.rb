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
    GameGuess.create!(:game_id => @game.id, :code => params[:guessed_code])
    @game_guesses = GameGuess.find_all_by_game_id(@game.id)
#    flash[:notice] = "#{@game.title} was successfully updated."
    if @game.check_code(params[:guessed_code]) == "4"
      redirect_to game_over_path(:game_id => @game.id)
    end
  end
      
  def over
  end

end
