class AddPersonIdToMoviesTable < ActiveRecord::Migration
  def up
    # add_column :movies, :person_id, :integer
    change_table :movies do |t|
      t.references :person
    end
  end

  def down
    remove_column :person_id
  end
end
