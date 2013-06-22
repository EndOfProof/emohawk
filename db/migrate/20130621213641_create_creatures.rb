class CreateCreatures < ActiveRecord::Migration
  def change
    create_table :creatures do |t|
			t.string "name"
			t.integer "age"
			t.integer "gender_cd"
			t.integer "mother_id"
			t.integer "father_id"
    end
  end
end
