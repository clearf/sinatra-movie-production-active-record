class AddPersonIdToTodo < ActiveRecord::Migration
  def up
    change_table :todos do |t|
      t.references :person
    end
  end

  def down
    remove_column :people, :person_id
  end
end
