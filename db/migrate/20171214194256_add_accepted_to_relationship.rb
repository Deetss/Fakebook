class AddAcceptedToRelationship < ActiveRecord::Migration[5.0]
  def change
    add_column :relationships, :acctepted, :boolean, default: false
  end
end
