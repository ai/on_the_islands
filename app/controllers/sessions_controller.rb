class SessionsController < ApplicationController
  def create
    @auth = Authentication.auth_by_hash(auth_hash)
    @user = @auth.user
    
    if current_user and not @user
      @user = current_user
      @user.authentications << @auth
      flash[:notice] = t.signin.add(@user.login, @auth.provider_name, @auth.uid)
    elsif @user.nil?
      @user = User.build_from_auth(auth_hash, @auth)
      flash[:notice] = t.signin.created(@user.login)
    end
    @user.save!
    session[:session_token] = @user.session_token
  rescue Mongoid::Errors::Validations
    flash[:notice] = nil
    raise unless @user.errors.has_key? :email
    if @user.email.blank?
      flash[:error] = t.signin.empty_email
    else
      occupier = User.where(email: @user.email).first.authentications.first
      flash[:error] = t.signin.occupied_email(@user.email, occupier.provider, 
                                              occupier.provider_name)
    end
  ensure
    redirect_to root_path # TODO. Save path
  end
  
  def destroy
    session.delete :session_token
    redirect_to root_path # TODO. Save path
  end
  
  private
  
  def auth_hash
    request.env['omniauth.auth'] 
  end
end
