class AddAdminToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :king, :boolean, default: false
  end
end
