class Movies < ActiveRecord::Migration
  def up
    create_table :movies do |t|
      t.string :title
      t.integer :release_date
      t.references :person
    end
  end

  def down
    drop_table :movies
  end
end
