class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.column :question, :text
      t.column :child_name, :string
      t.column :child_email, :string
      t.column :child_age, :string
      t.column :child_city, :string
      t.column :child_state, :string
      t.column :child_school, :string
      t.column :accepted, :boolean, :default => false
    end
  end

  def self.down
    drop_table :questions
  end
end
