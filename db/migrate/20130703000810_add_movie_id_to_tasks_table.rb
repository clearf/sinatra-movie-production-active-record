class AddMovieIdToTasksTable < ActiveRecord::Migration
  def up
    change_table :tasks do |t|
      t.references :movie
    end
  end

  def down
    remove_column :tasks, :movie_id
  end
end
