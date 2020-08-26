class RemoveSvmFannFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :svm, :decimal
    remove_column :posts, :fann, :decimal
  end
end
