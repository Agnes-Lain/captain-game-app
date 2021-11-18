class CreateCombats < ActiveRecord::Migration[6.1]
  def change
    create_table :combats do |t|
      t.references :fighter, null: false, foreign_key: true
      t.integer :adversary_id, null: false
      t.integer :result

      t.timestamps null: false
    end

    add_index :combats, :adversary_id

  end
end
