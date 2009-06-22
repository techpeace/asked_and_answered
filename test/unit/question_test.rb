require File.dirname(__FILE__) + '/../test_helper'

context "A question" do
  
  setup do
    @question = Question.new
  end
  
  specify "should have child name" do
    assert_attribute_required(@question, :child_name)
  end
  
  specify "should have child age" do
    assert_attribute_required(@question, :child_age)
  end
  
  specify "should have child city" do
    assert_attribute_required(@question, :child_city)
  end
  
  specify "should have child state" do
    assert_attribute_required(@question, :child_state)
  end
  
  specify "should have question" do
    assert_attribute_required(@question, :question)
  end
  
end
