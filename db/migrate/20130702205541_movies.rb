class Movies < ActiveRecord::Migration
  def up
  	create_table :movies do |t|
  		t.string :title
  		t.string :description
  		t.references :director_id
  		t.timestamps
  	end
  end

  def down
  	drop_table :movies
  end
end
