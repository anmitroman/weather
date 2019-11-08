class AddLonToCities < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :lon, :float
  end
end
