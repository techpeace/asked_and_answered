class CreateUsersAndDropExperts < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string
      t.column :email,                     :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
      t.column :is_admin,                  :boolean, :default => false
      t.column :full_name,                 :string
      t.column :bio,                       :text
      
      t.column :activation_code, :string, :limit => 40
      t.column :activated_at, :datetime
    end
    
    drop_table "experts"
    
    # Create an admin user for myself.
    User.create(:login => "admin", 
                :email => "techpeace@gmail.com",
                :full_name => "Matthew Buck",
                :password => "m4rs4dm1n",
                :password_confirmation => "m4rs4dm1n")
    admin = User.find(:first)
    admin.is_admin = true
    admin.activate
    admin.save
  end

  def self.down
    drop_table "users"
    
    create_table "experts", :force => true do |t|
      t.column :login,                     :string
      t.column :email,                     :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
    end
  end
end
