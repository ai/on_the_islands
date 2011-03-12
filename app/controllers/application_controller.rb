class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def current_user
    @current_user ||= begin
      token = session[:session_token]
      User.where(session_token: token).first if token
    end
  end
  
  def signed_in?
    !!current_user
  end
  
  helper_method :current_user, :signed_in?
  
  def current_user=(user)
    @current_user = user
    session[:session_token] = user.session_token
  end
end
