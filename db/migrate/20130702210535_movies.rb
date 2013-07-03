class Movies < ActiveRecord::Migration
  def up
     create_table :movies do |t|
      t.string :release_date
      t.string :title
      t.string :director
    end
  end
  def down
    drop_table :movies
  end
end
