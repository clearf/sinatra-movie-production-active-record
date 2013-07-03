class CreateTodos < ActiveRecord::Migration
  def up
    create_table :todos do |t|
      t.string :todo
      t.string :note
      t.boolean :status, default: false
      t.timestamps
    end
  end

  def down
    drop_table :todos
  end
end
