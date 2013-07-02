class AddTaskIdAndMovieIdToPeopleTable < ActiveRecord::Migration
  def up
    # add_column :people, :task_id, :integer
    # add_column :people, :movie_id, :integer
    change_table :people do |t|
      t.references :task
      t.references :movie
    end
  end

  def down
    remove_column :task_id
    remove_column :movie_id
  end
end
