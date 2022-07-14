class AddPublishTToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :publishT, :time
  end
end
