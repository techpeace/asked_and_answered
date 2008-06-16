class Question < ActiveRecord::Base
  has_one :answer
  belongs_to :questioner

  def answered?
    !answer.nil?
  end
  
  def self.recent
    find(:all, :limit => 4, :order => 'created_at DESC')
  end
end
