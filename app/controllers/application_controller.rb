class ApplicationController < ActionController::Base
  before_filter :authorize
  before_filter :authorize_admin
  
  protected
  
  def authorize
      User.find session[:user_id]
      rescue ActiveRecord::RecordNotFound
        redirect_to login_url, notice: "Please log in"

  end

  def authorize_admin
      @admin=User.find session[:user_id]

      if !@admin.is_admin 
        redirect_to login_url, notice: "Please log in with an admin user"
      end
  end


  
end
