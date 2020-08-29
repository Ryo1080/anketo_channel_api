class CreateAnketos < ActiveRecord::Migration[6.0]
  def change
    create_table :anketos do |t|
      t.string :title, null: false
      t.string :description
      t.string :image
      t.integer :category, null: false
      t.timestamps
    end
  end
end
