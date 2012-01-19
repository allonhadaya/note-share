class CreateNotes < ActiveRecord::Migration
	def self.up
		create_table :notes do |t|
			t.string :name
			t.references :group
			t.timestamps
		end
	end

	def self.down
		drop_table :notes
	end
end
