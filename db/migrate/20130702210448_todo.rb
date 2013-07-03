class Todo < ActiveRecord::Migration
  def up
     create_table :todos do |t|
      t.string :name
      t.string :description
      t.string :contact
      t.string :movie
    end
  end
  def down
    drop_table :todo
  end
end
