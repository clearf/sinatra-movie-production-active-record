class AddTodoIdAndMovieIdToPeopleTable < ActiveRecord::Migration
  def up
    # add_column :people, :todo_id, :integer
    # add_column :people, :movie_id, :integer
    change_table :people do |t|
      t.references :todo
      t.references :movie
    end
  end

  def down
    remove_column :todo_id
    remove_column :movie_id
  end
end
