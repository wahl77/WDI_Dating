class AddFirstNameLastNameInterestedInToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :interested_in_male, :boolean, default: true
  end
end
