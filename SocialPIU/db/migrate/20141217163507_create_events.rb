class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :description
      t.string :direction
      t.boolean :enable
      t.boolean :iduser
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
