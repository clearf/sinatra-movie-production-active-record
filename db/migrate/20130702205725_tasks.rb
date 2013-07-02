class Tasks < ActiveRecord::Migration
  def up
  	create_table :todos do |t|
  		t.string :task
  		t.string :details
  		t.string :due
  		t.boolean :urgent
  		t.boolean :complete
		t.references :person
		t.references :movie
	end
  end

  def down
  end
end
