class AddMovieIdToTodo < ActiveRecord::Migration
  def up
    change_table :todos do |t|
      t.references :movie
    end
  end

  def down
    remove_column :movies, :movie_id
  end
end
