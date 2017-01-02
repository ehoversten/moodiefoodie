class AddDetailsToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :restaurant_name, :string
    add_column :restaurants, :food_type, :string
    add_column :restaurants, :restaurant_description, :text
    add_column :restaurants, :restaurant_id, :integer
  end
end
