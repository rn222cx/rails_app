class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.references :user, index: true

      t.string :name
      t.boolean :income
      t.timestamps
    end
  end
end
