# This controller handles the login/logout function of the site.  
class LoginController < ApplicationController  
  def index
    @body_id = "login"
  end
  
  def authenticate
    sleep 3
    
    if params[:password] = "m4rs4dm1n"
      session[:admin] = true
    elsif 
      
  end
end