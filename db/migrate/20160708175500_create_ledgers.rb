class CreateLedgers < ActiveRecord::Migration[5.0]
  def change
    create_table :ledgers do |t|
      t.references :user, index: true
      t.references :category, index: true

      t.date :day
      t.string :category
      t.decimal :amount
      t.string :text
      t.timestamps
    end
  end
end
