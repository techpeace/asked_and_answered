require File.dirname(__FILE__) + '/../test_helper'
require 'questions_controller'

# Re-raise errors caught by the controller.
class QuestionsController; def rescue_action(e) raise e end; end

class QuestionsControllerTest < Test::Unit::TestCase
  fixtures :questions, :users

  def setup
    @controller = QuestionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:user] = users(:quentin).id
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:questions)
  end
  
  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_question
    old_count = Question.count
    post :create, :question => { :question => "Is Mars hot?", :child_name => "Jacob", :child_age => "5 years old", :child_city => "Austin", :child_state => "Texas"}
    assert_equal old_count+1, Question.count 
    
    assert_redirected_to question_path(assigns(:question))
  end

  def test_should_show_question
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_question
    put :update, :id => 1, :question => { }
    assert_redirected_to question_path(assigns(:question))
  end
  
  def test_should_destroy_question
    old_count = Question.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Question.count
    
    assert_redirected_to questions_path
  end
end
