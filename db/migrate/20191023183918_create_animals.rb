class CreateAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :scientific_name
      t.integer :danger_rating
      t.string :animal_fact
      t.boolean :predator
    end
  end
end
