class AddIsFreezeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_freeze, :boolean, default: false, null: false
  end
end
