class AddGeoToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :lat, :decimal
    add_column :posts, :lng, :decimal
  end
end
