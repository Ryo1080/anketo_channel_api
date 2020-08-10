class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.string :ip, null: false
      t.references :anketo_option, foreign_key: true
      t.timestamps
    end
  end
end
