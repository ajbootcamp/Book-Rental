class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :available_quantity
      t.integer :total_quantity

      t.timestamps
    end
  end
end
