class People < ActiveRecord::Migration
  def up
     create_table :people do |t|
      t.string :name
      t.string :movie
      t.string :task
    end
  end
  def down
    drop_table :people
  end
end
