class CreateMovies < ActiveRecord::Migration
  def up
    create_table :movies do |t|
      t.string :name
      t.date :release_date
      t.timestamps
    end
  end

  def down
    drop_table :movies
  end
end
