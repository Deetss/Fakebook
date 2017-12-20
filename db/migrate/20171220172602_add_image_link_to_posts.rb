class AddImageLinkToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :image_link, :string
  end
end
