class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :title
      t.text :content
      t.text :link
      t.text :author
      t.text :type
      t.decimal :svm
      t.decimal :fann
      t.decimal :rank

      t.timestamps
    end
  end
end
