class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.datetime :date_created, null: false
      t.integer :user_id, null: false
      t.integer :interest_group_id, null: false

      t.timestamps
    end
  end
end
