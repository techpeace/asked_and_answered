class AddNameAndBioToExpert < ActiveRecord::Migration
  def self.up
    add_column :experts, :name, :string
    add_column :experts, :biography, :string
  end

  def self.down
    remove_column :experts, :name
    remove_column :experts, :biography
  end
end
