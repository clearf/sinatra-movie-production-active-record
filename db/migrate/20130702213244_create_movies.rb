class CreateMovies < ActiveRecord::Migration
  def up
    create_table :movies do |t|
      t.string :title
      t.string :year
      t.string :company
      t.string :genres
      t.string :length
      t.string :director
      t.string :mpaa_rating
      t.string :poster
      t.timestamps
    end
  end

  def down
    drop_table :movies
  end
end
