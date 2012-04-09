class GameController < ApplicationController
  def new
  end

  def playing
	@secret_code='ABCD'
	if params[:firstCell] + params[:secondCell]+params[:thirdCell]+params[:fourthCell] == @secret_code
		redirect_to game_over_path :result => "success"
	end
  end

  def over
  end

end
