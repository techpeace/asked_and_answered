# This controller handles the login/logout function of the site.  
class AuthenticationController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  before_filter :set_body_id
  
  # render new.rhtml
  def new
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      
      flash[:notice] = "Login successful"
      render :update do |page| 
        page.redirect_to users_path
      end
    else
      # Alert the user that their login attempt has been unsuccessful.
      flash[:error] = "Incorrect - try again"
      render_flash
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "Logout successful"
    redirect_to "/login"
  end
  
private

  def set_body_id
    @body_id = "login"
  end
end
