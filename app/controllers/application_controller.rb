class ApplicationController < ActionController::Base
#  protect_from_forgery
  
  def login_required
    if session[:user]
      return true
    end
    
    flash[:warning] = 'Please login to continue'
    session[:return_to] = request.fullpath
    redirect_to "/index.html#section_magauch"
    return false
  end

  def current_user
    session[:user]
  end
end
