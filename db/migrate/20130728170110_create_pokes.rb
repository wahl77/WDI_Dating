class CreatePokes < ActiveRecord::Migration
  def change
    create_table :pokes do |t|
      t.references :poker
      t.references :pokee
      t.boolean :wink, default: :false
      t.boolean :viewed, default: false

      t.timestamps
    end
    add_index :pokes, :poker_id
    add_index :pokes, :pokee_id
  end
end
