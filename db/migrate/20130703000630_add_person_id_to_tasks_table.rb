class AddPersonIdToTasksTable < ActiveRecord::Migration
  def up
    change_table :tasks do |t|
      t.references :person
    end
  end

  def down
    remove_column :tasks, :person_id
  end
end