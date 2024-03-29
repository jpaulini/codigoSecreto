class GameController < ApplicationController
  skip_before_filter :authorize_admin
  
  def new
    @user = User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to login_url
    else
    @game= @user.games.create!
     redirect_to game_start_path(:game_id => @game.id)
  end
  
  def start
    @user = User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to login_url
    else

    @game = @user.games.find params[:game_id]
  end

  def playing
    @user = User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to login_url
    else

    @game = @user.games.find params[:game_id]
    session[:last_code] = params[:code]
    
    code_text = params[:code].values.join if not params[:code].nil?
    guess = @game.game_guesses.build(code: code_text )
    guess.result = @game.check_code(code_text)
    guess.save

    if @game.check_code(code_text) == "4"
      redirect_to game_over_path(:game_id => @game.id)
    else
      if guess.ord == 10 
          redirect_to game_over_path(:game_id => @game.id)
      end
    end
    
  end
      
  def over
    @user = User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to login_url
    else

     @game = @user.games.find params[:game_id]
     @n_guesses = @game.game_guesses.count
     if @n_guesses <= 10 and @game.game_guesses.last.result == 4
        @message = "Muy bien!"
     else
        @message = "Mala suerte!"
     end
     
  end

end
