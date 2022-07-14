class AddPublishToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :publish, :datetime
  end
end
