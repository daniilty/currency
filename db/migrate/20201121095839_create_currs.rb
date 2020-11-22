class CreateCurrs < ActiveRecord::Migration[6.0]
  def change
    create_table :currs do |t|
      t.string :current

      t.timestamps
    end
  end
end
