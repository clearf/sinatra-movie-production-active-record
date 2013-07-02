class CreateTask < ActiveRecord::Migration
  def up
    create_table :tasks do |t|
    t.string :name
    t.string :description
    t.references :movie
    t.references :person
    t.timestamps
    end
  end

  def down
    drop_table :tasks
  end
end
