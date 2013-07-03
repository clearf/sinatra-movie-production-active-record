class AddMovieIdToPeople < ActiveRecord::Migration
  def up
    change_table :people do |t|
      t.references :movie
    end
  end

  def down
    remove_column :people, :movie_id
  end
end
