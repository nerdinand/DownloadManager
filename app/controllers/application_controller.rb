class ApplicationController < ActionController::Base
  protect_from_forgery :except=>:create

  def login_required

    puts params.inspect

    if params["format"].eql? "json"
#      if user = authenticate_with_http_basic { |u, p| @account.users.authenticate(u, p) }
 #       session[:user] = user
  #    else
        #request_http_basic_authentication
   #   end
    else
      if session[:user]
        return true
      end
      flash[:warning]='Please login to continue'

      if request.method.eql? :get
        session[:return_to]=request.fullpath
        #puts ">>>>>>>> redirect saved: #{session[:return_to]}"
      end

      redirect_to :controller => "users", :action => "login"
      return false
    end
  end

  def current_user
    session[:user]
  end

  def redirect_to_stored
    if return_to = session[:return_to]
      session[:return_to]=nil
      #puts ">>>>>>>> redirecting to #{return_to}"
      redirect_to(return_to)
    else
      redirect_to :controller=>'uploads', :action=>'index'
    end
  end

end
