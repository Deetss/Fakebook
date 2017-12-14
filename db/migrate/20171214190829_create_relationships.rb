class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.integer :requestee_id
      t.integer :requested_id

      t.timestamps
    end
    add_index :relationships, :requestee_id
    add_index :relationships, :requested_id
    add_index :relationships, [:requested_id, :requestee_id], unique: true
  end
end
