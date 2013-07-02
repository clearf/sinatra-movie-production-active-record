class MoviesAgain < ActiveRecord::Migration
  def up
  	create_table :movies do |t|
  		t.string :title
  		t.string :description
  		t.references :person
  		t.timestamps
  	end
  end

  def down
  	drop_table :movies
  end
end
