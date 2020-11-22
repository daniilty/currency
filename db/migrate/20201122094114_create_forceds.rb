class CreateForceds < ActiveRecord::Migration[6.0]
  def change
    create_table :forceds do |t|
      t.string :value
      t.datetime :dt

      t.timestamps
    end
  end
end
