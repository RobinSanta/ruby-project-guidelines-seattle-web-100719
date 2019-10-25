class CreateBiomes < ActiveRecord::Migration[5.2]
  def change
    create_table :biomes do |t|
      t.integer :animal_id
      t.integer :state_id
    end
  end
end
