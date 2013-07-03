class AddMovieIdToPeople < ActiveRecord::Migration
  def up
    change_table :people do |t|
      t.references :movies
    end
  end

  def down
    remove_column :people, :movies_id
  end
end
