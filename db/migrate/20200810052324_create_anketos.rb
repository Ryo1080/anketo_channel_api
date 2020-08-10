class CreateAnketos < ActiveRecord::Migration[6.0]
  def change
    create_table :anketos do |t|
      t.string :title, null: false
      t.string :desctiption
      t.string :image
      t.timestamps
    end
  end
end
