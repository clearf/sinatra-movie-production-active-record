class AddPersonIdToTasksTable < ActiveRecord::Migration
  def up
    change_table :tasks do |t|
      t.references :people
    end
  end

  def down
    remove_column :tasks, :people_id
  end
end