class AddTodoIdAndPersonIdToMoviesTable < ActiveRecord::Migration
  def up
    # add_column :movies, :todo_id, :integer
    # add_column :movies, :person_id, :integer
    change_table :movies do |t|
      t.references :todo
      t.references :person
    end
  end

  def down
    remove_column :todo_id
    remove_column :person_id
  end
end
