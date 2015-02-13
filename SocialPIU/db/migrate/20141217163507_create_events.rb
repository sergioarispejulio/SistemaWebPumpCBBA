class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :description
      t.string :direction
      t.boolean :enable
      t.integer :iduser
      t.string :name
      t.string :tipo
      t.date :date_create
      t.date :date_modify
      
      t.timestamps
    end
  end
end
