require File.dirname(__FILE__) + '/../test_helper'

class AnswerTest < Test::Unit::TestCase
  fixtures :answers, :questions

  def test_validates_presence_of_question
    answer = Answer.new
    assert !answer.valid?
    assert_equal "can't be blank", answer.errors[:question]
  end

  def test_validates_presence_of_user
    answer = Answer.new
    assert !answer.valid?
    assert_equal "can't be blank", answer.errors[:user]
  end

  def test_validates_presence_of_answer
    answer = Answer.new
    assert !answer.valid?
    assert_equal "can't be blank", answer.errors[:answer]
  end
end
