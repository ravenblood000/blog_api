class AddPublishDToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :publishD, :date
  end
end
