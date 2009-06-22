class Question < ActiveRecord::Base
  has_one :answer

  validates_presence_of :child_name, :child_age, :child_city, :child_state, :question

  def answered?
    !answer.nil?
  end
end
