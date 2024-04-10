class AddFiledTypePriceToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :post_type, :string
    add_column :posts, :price, :integer
  end
end
