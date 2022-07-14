class AddFloaterToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :floater, :float
  end
end
