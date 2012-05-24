#module AuthenticationHelpers
  def login(user)
    session[:user_id] = user.id # session is nil
    #controller.stub!(:current_user).and_return(user) # controller is nil
  end
#end
