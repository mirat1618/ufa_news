class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.text :title
      t.text :content
      t.text :link
      t.text :author

      t.timestamps
    end
  end
end