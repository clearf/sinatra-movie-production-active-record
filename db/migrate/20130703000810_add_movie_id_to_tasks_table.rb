class AddMovieIdToTasksTable < ActiveRecord::Migration
  def up
    change_table :tasks do |t|
      t.references :movies
    end
  end

  def down
    remove_column :tasks, :movies_id
  end
end
