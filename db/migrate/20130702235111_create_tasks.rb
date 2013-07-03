class CreateTasks < ActiveRecord::Migration
  def up
    create_table :tasks do |t|
      t.string :task
      t.string :description
      t.boolean :completed, default: false
      t.timestamps
    end
  end

  def down
    drop_table :tasks
  end
end
