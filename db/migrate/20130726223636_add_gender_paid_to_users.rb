class AddGenderPaidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paid, :boolean, default: false
    add_column :users, :male, :boolean, default: true
  end
end
