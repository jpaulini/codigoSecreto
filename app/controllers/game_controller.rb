class GameController < ApplicationController
  def new
  end

  def playing
	@round="XXXX"
	if not params.nil?
	  @round=params[:firstCell] + params[:secondCell]+params[:thirdCell]+params[:fourthCell]
	end
	@result=Game.check_code(@round)
	if  @result == "4" 
		redirect_to game_over_path :result => "success"
	end
  end

  def over
  end

end
