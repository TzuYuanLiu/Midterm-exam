class CreatePostCategoryShips < ActiveRecord::Migration
  def change
    create_table :post_category_ships do |t|

      t.timestamps null: false
    end
  end
end
