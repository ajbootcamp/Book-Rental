class AddPersonalInfoToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :firstname, :string
    add_column :users, :middlename, :string
    add_column :users, :lastname, :string
    add_column :users, :age, :integer
    add_column :users, :phonenumber, :string
    add_column :users, :gender, :string
  end
end
