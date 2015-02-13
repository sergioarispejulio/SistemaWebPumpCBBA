class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email,            :null => false
      t.string :crypted_password, :null => false
      t.string :salt,             :null => false
      t.string :Type,             :null => false
      t.boolean :Enable,            :null => false 
	  t.string :Name
	  t.string :LastName 
	  t.string :Genre 
	  t.string :Country 
	  t.string :City 
	  t.date :Birthday 
	  t.string :Nickname 
    t.boolean :Admi
      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end