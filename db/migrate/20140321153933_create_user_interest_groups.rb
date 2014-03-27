class CreateUserInterestGroups < ActiveRecord::Migration
  def change
    create_table :user_interest_groups do |t|
      t.integer :user_id, null: false
      t.integer :interest_group_id, null: false

      t.timestamps
    end
  end
end
