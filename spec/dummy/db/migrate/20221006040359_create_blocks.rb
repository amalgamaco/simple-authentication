class CreateBlocks < ActiveRecord::Migration[7.0]
  def change
	  create_table :blocks do |t|
		  t.references :blocker, null: false, foreign_key: { to_table: :users }
		  t.references :blocked_user, null: false, foreign_key: { to_table: :users }

		  t.index [:blocker_id, :blocked_user_id], unique: true

		  t.timestamps
	  end
  end
end
