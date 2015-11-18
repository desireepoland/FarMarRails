class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.integer :id
      t.string :name
      t.integer :employees
      t.integer :market_id

      t.timestamps null: false
    end
  end
end
