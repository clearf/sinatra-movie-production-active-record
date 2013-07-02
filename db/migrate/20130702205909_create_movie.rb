class CreateMovie < ActiveRecord::Migration
  def up
    create_table :movies do |t|
    t.string :name
    t.references :person
    t.timestamps
    end
  end

  def down
    drop_table :movies
  end
end
