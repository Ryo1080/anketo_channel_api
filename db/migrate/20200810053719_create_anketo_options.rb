class CreateAnketoOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :anketo_options do |t|
      t.string :option, null: false
      t.references :anketo, foreign_key: true
      t.timestamps
    end
  end
end
