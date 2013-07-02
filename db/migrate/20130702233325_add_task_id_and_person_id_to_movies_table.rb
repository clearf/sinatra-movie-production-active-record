class AddTaskIdAndPersonIdToMoviesTable < ActiveRecord::Migration
  def up
    # add_column :movies, :task_id, :integer
    # add_column :movies, :person_id, :integer
    change_table :movies do |t|
      t.references :task
      t.references :person
    end
  end

  def down
    remove_column :task_id
    remove_column :person_id
  end
end
