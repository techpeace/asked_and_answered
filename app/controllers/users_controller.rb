class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie

  # GET new_user_url
  def new
    # return an HTML form for describing a new user
    @user = User.new
  end

  # POST user_url
  def create
    # create a new user
    @user = User.new(params[:user])
    @user.save!
    self.current_user = @user
    flash[:notice] = "User created"
    redirect_to users_path
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

  def activate
    self.current_user = User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.activated?
      current_user.activate
      flash[:notice] = "Signup complete!"
    end
    redirect_back_or_default('/')
  end
  
  # GET users_url
  def index
    # return all users
    @users = User.find(:all)
  end
  
  # GET user_url
  def show
    # find and return the user
  end
  
  # GET edit_user_url(:id => 1)
  def edit
    # return an HTML form for editing a specific user
    @user = User.find(params[:id])
  end

  # PUT user_url(:id => 1)
  def update
    # find and update a specific user
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:notice] = 'User updated'
      redirect_to users_path
    else
      flash[:error] = 'Update error'
      render :action => "edit", :id => @user
    end
  end
  
  # DELETE user_url
  def destroy
    # delete the user
    user = User.find(params[:id])
    row_id = dom_id(user)
    
    if user.destroy
      flash[:notice] = "User deleted"
      flash.discard(:notice)
      render_flash do |page|
        page.delay(2) { page.visual_effect :fade, row_id, :duration => 2 }
      end
    else
      flash[:error] = "User was not deleted"
      flash.discard(:error)
      render_flash
    end
  end
end