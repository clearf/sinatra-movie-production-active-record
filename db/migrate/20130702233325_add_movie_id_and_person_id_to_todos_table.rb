class AddMovieIdAndPersonIdToTodosTable < ActiveRecord::Migration
  def up
    # add_column :todos, :movie_id, :integer
    # add_column :todos, :person_id, :integer
    change_table :todos do |t|
      t.references :movie
      t.references :person
    end
  end

  def down
    remove_column :movie_id
    remove_column :person_id
  end
end
