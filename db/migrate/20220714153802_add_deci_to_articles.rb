class AddDeciToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :deci, :decimal
  end
end
