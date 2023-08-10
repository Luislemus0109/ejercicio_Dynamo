class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :propietario
      t.string :color
      t.integer :modelo
      t.integer :placa

      t.timestamps
    end
  end
end
