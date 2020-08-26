class RenameTypeToCategory < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :type, :category
  end
end
