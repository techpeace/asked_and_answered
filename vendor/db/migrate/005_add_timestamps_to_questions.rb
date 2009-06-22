class AddTimestampsToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :created_at, :datetime
    add_column :questions, :updated_at, :datetime
  end

  def self.down
    remove_column :questions, :created_at
    remove_column :questions, :updated_at
  end
end
