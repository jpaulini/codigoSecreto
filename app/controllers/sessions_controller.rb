class SessionsController < ApplicationController
  skip_before_filter :authorize
  
  def new
  end

  def create
    user = User.find_by_name(params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id]=user.id
      if user.is_admin
        redirect_to admin_url
      else
        redirect_to game_new_url
      end
    end
  end

  def destroy
    session[:user_id]=nil
    redirect_to root_url
  end

end
