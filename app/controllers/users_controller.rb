class UsersController < ApplicationController
  def login
    if request.post?
      session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
      if session[:user]
        flash[:notice]  = "Login successful"
        redirect_to_stored
      else
        flash[:warning] = "Login unsuccessful"
      end
    end
  end

  def logout
    session[:user]=nil
    flash[:notice]  = "Logout successful"
    redirect_to_stored
  end
end
