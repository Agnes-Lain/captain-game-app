class CreateFighters < ActiveRecord::Migration[6.1]
  def change
    create_table :fighters do |t|
      t.string :name
      t.integer :life_points
      t.integer :attack_points

      t.timestamps
    end
  end
end
