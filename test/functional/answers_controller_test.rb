require File.dirname(__FILE__) + '/../test_helper'
require 'answers_controller'

# Re-raise errors caught by the controller.
class AnswersController; def rescue_action(e) raise e end; end

class AnswersControllerTest < Test::Unit::TestCase
  fixtures :answers, :questions, :users

  def setup
    @controller = AnswersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:user] = users(:quentin).id
  end

  def test_should_get_new
    get :new, :question_id => questions(:why_is_mars_red).id
    assert_response :success
  end
  
  def test_should_create_answer
    old_count = Answer.count
    post :create, :question_id => questions(:why_is_mars_red).id, :answer => { }
    assert_equal old_count+1, Answer.count
    
    assert_redirected_to answer_path(questions(:why_is_mars_red), assigns(:answer))
  end

  def test_should_get_edit
    get :edit, :id => 1, :question_id => questions(:why_is_mars_red).id
    assert_response :success
  end
  
  def test_should_update_answer
    put :update, :id => 1, :question_id => questions(:why_is_mars_red).id, :answer => { }
    assert_redirected_to answer_path(questions(:why_is_mars_red), assigns(:answer))
  end
  
  def test_should_destroy_answer
    old_count = Answer.count
    delete :destroy, :id => 1, :question_id => questions(:why_is_mars_red).id
    assert_equal old_count-1, Answer.count
    
    assert_redirected_to answers_path(questions(:why_is_mars_red))
  end
end
