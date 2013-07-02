class Tasks < ActiveRecord::Migration
  def up
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.references :person
      t.references :movie
  end

  def down
  end
end
