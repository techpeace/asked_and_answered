class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :expert

  validates_presence_of :question, :expert, :answer
end
