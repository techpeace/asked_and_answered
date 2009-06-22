class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.column :question_id, :integer
      t.column :user_id, :integer
      t.column :answer, :text
    end
  end

  def self.down
    drop_table :answers
  end
end
