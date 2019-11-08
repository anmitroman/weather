class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.integer :code
      t.string :country
      t.boolean :display

      t.timestamps
    end
  end
end
