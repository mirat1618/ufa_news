class AddImageSourceToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :image_source, :text
  end
end
