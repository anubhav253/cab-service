class CreateDriver < ActiveRecord::Migration[6.1]
  def change
    create_table :drivers do |t|
      t.string :name, null: false
      t.string :mobile_number, null: false, unique: true

      t.timestamps
    end
  end
end
