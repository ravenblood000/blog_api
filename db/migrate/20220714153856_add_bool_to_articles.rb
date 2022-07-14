class AddBoolToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :bool, :boolean
  end
end
