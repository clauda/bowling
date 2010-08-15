class CreatePostCategories < ActiveRecord::Migration
  def self.up
    create_table :post_categories, :id => false do |t|
      t.references :post, :null => false
      t.references :category, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :post_categories
  end
end
