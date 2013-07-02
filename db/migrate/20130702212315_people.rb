class People < ActiveRecord::Migration
  def up
    create_table :people do |t|
      t.string :name
      t.references :movie
      t.references :task
  end

  def down
    drop_table :people
  end
end
