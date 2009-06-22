require File.dirname(__FILE__) + '/../test_helper'
require 'experts_controller'

# Re-raise errors caught by the controller.
class ExpertsController; def rescue_action(e) raise e end; end

class ExpertsControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  # Then, you can remove it from this and the units test.
  include AuthenticatedTestHelper

  fixtures :experts

  def setup
    @controller = ExpertsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:expert] = experts(:hal).id
  end

  def test_should_allow_signup
    assert_difference Expert, :count do
      create_expert
      assert_response :redirect
    end
  end

  def test_should_require_login_on_signup
    assert_no_difference Expert, :count do
      create_expert(:login => nil)
      assert assigns(:expert).errors.on(:login)
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    assert_no_difference Expert, :count do
      create_expert(:password => nil)
      assert assigns(:expert).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference Expert, :count do
      create_expert(:password_confirmation => nil)
      assert assigns(:expert).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference Expert, :count do
      create_expert(:email => nil)
      assert assigns(:expert).errors.on(:email)
      assert_response :success
    end
  end
  

  protected
    def create_expert(options = {})
      post :create, :expert => { :login => 'quire', :email => 'quire@example.com', 
        :password => 'quire', :password_confirmation => 'quire', :name => "boo", :biography => "bash" }.merge(options)
    end
end
