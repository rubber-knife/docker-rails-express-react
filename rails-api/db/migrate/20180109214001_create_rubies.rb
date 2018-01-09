class CreateRubies < ActiveRecord::Migration[5.1]
  def change
    create_table :rubies do |t|
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
