class RenameAccteptedToAccepted < ActiveRecord::Migration[5.0]
  def change
    rename_column :relationships, :acctepted, :accepted
  end
end
