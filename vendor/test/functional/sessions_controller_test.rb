require File.dirname(__FILE__) + '/../test_helper'
require 'sessions_controller'

# Re-raise errors caught by the controller.
class SessionsController; def rescue_action(e) raise e end; end

class SessionsControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  # Then, you can remove it from this and the units test.
  include AuthenticatedTestHelper

  fixtures :experts

  def setup
    @controller = SessionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :create, :login => 'hal', :password => 'test'
    assert session[:expert]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :create, :login => 'hal', :password => 'bad password'
    assert_nil session[:expert]
    assert_response :success
  end

  def test_should_logout
    login_as :hal
    get :destroy
    assert_nil session[:expert]
    assert_response :redirect
  end

  def test_should_remember_me
    post :create, :login => 'hal', :password => 'test', :remember_me => "1"
    assert_not_nil @response.cookies["auth_token"]
  end

  def test_should_not_remember_me
    post :create, :login => 'hal', :password => 'test', :remember_me => "0"
    assert_nil @response.cookies["auth_token"]
  end
  
  def test_should_delete_token_on_logout
    login_as :hal
    get :destroy
    assert_equal @response.cookies["auth_token"], []
  end

  def test_should_login_with_cookie
    experts(:hal).remember_me
    @request.cookies["auth_token"] = cookie_for(:hal)
    get :new
    assert @controller.send(:logged_in?)
  end

  def test_should_fail_expired_cookie_login
    experts(:hal).remember_me
    experts(:hal).update_attribute :remember_token_expires_at, 5.minutes.ago
    @request.cookies["auth_token"] = cookie_for(:hal)
    get :new
    assert !@controller.send(:logged_in?)
  end

  def test_should_fail_cookie_login
    experts(:hal).remember_me
    @request.cookies["auth_token"] = auth_token('invalid_auth_token')
    get :new
    assert !@controller.send(:logged_in?)
  end

  protected
    def auth_token(token)
      CGI::Cookie.new('name' => 'auth_token', 'value' => token)
    end
    
    def cookie_for(expert)
      auth_token experts(expert).remember_token
    end
end
